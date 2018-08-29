<template>
  <paginate
    name="allTasks"
    :list="tasks"
    :per="5"
  >
    <li v-for="task in paginated('allTasks')">
        {{ task.title }}
    </li>
  </paginate>
</template>

<script>
export default {
}
</script>

<style scoped>
</style>
