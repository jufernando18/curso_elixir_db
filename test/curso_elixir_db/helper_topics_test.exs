defmodule CursoElixirDb.HelperTopicsTest do
  use CursoElixirDb.DataCase

  alias CursoElixirDb.HelperTopics

  describe "topics" do
    alias CursoElixirDb.HelperTopics.Topics

    @valid_attrs %{description: "some description", gradient: "some gradient", score: "some score", title: "some title"}
    @update_attrs %{description: "some updated description", gradient: "some updated gradient", score: "some updated score", title: "some updated title"}
    @invalid_attrs %{description: nil, gradient: nil, score: nil, title: nil}

    def topics_fixture(attrs \\ %{}) do
      {:ok, topics} =
        attrs
        |> Enum.into(@valid_attrs)
        |> HelperTopics.create_topics()

      topics
    end

    test "list_topics/0 returns all topics" do
      topics = topics_fixture()
      assert HelperTopics.list_topics() == [topics]
    end

    test "get_topics!/1 returns the topics with given id" do
      topics = topics_fixture()
      assert HelperTopics.get_topics!(topics.id) == topics
    end

    test "create_topics/1 with valid data creates a topics" do
      assert {:ok, %Topics{} = topics} = HelperTopics.create_topics(@valid_attrs)
      assert topics.description == "some description"
      assert topics.gradient == "some gradient"
      assert topics.score == "some score"
      assert topics.title == "some title"
    end

    test "create_topics/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = HelperTopics.create_topics(@invalid_attrs)
    end

    test "update_topics/2 with valid data updates the topics" do
      topics = topics_fixture()
      assert {:ok, %Topics{} = topics} = HelperTopics.update_topics(topics, @update_attrs)
      assert topics.description == "some updated description"
      assert topics.gradient == "some updated gradient"
      assert topics.score == "some updated score"
      assert topics.title == "some updated title"
    end

    test "update_topics/2 with invalid data returns error changeset" do
      topics = topics_fixture()
      assert {:error, %Ecto.Changeset{}} = HelperTopics.update_topics(topics, @invalid_attrs)
      assert topics == HelperTopics.get_topics!(topics.id)
    end

    test "delete_topics/1 deletes the topics" do
      topics = topics_fixture()
      assert {:ok, %Topics{}} = HelperTopics.delete_topics(topics)
      assert_raise Ecto.NoResultsError, fn -> HelperTopics.get_topics!(topics.id) end
    end

    test "change_topics/1 returns a topics changeset" do
      topics = topics_fixture()
      assert %Ecto.Changeset{} = HelperTopics.change_topics(topics)
    end
  end
end
