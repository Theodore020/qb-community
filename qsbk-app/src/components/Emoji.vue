<template>
    <div class="box-border p-[8px]">
        <div class="text-center py-[8px]">表情包</div>
        <div class="emoji-grid-box">
            <span
                @click="$emit('choose', item)"
                v-for="(item, index) in emojis"
                :key="index">{{ item }}
            </span>
        </div>
    </div>
</template>
<script setup>
import { defineEmits } from "vue";

const emit = defineEmits(["choose"]);
const emojis = [
    '😍', '😀', '😡', '😁', '😆', '😅', '🤣', '😂',
    '🙂', '😉', '🥰', '🤩', '😘', '😙', '😱', '😜',
    '🤪', '🤑', '🤗', '🤭', '🤐', '🤨', '😐', '😑',
    '😒', '💢', '🙄', '😬', '😌', '🤤', '😷', '🤕',
    '🤢', '🤮', '🤧', '🥵', '🥶', '😵', '😎', '😭'
]
</script>
<style scoped lang="scss">
.emoji-grid-box {
    display: grid;
    grid-template-columns: repeat(auto-fill, 30px);
    grid-gap: 10px;
    justify-items: center;

    span {
        font-size: 18px;
    }
}
</style>