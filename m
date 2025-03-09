Return-Path: <linux-can+bounces-3029-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 351AFA58335
	for <lists+linux-can@lfdr.de>; Sun,  9 Mar 2025 11:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8F816BC00
	for <lists+linux-can@lfdr.de>; Sun,  9 Mar 2025 10:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7075B1C5D4A;
	Sun,  9 Mar 2025 10:46:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D521C5D45
	for <linux-can@vger.kernel.org>; Sun,  9 Mar 2025 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741517184; cv=none; b=BruuxYR006X94t8p8vM8NZrNWWmMs5PUwSwSOLNc/v4NNfpbi/eniFIZBUGwaj8csliQeXxX5tYOiExe22ROZLc8SDY4dUFYvVRYk3qGJDnhpmr+fZgLUCwHj1iK79DOSZIGyDfNCvOFmZWrig3jxui5vzgs9+S+dDvgMDfgkYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741517184; c=relaxed/simple;
	bh=FVqO0IZhKzpyNhoeFF+PIXD3POnSYl1Rj54YaoYG5VY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QpwxyuAeEMnpaAaduGBpM2sS+SehCyiARE/pmHs2h0MXqIm6aRae22Hn3rnFQxOjpLBoWcFCooTSBicz1Zh/z+CIzzju/HdUbegIcd2hJ+zIh6ODZH5un3AQwpwLIUxHpS8ehd5zzn2UgQV3xLAZoDuUj0DRgjQSjV7pdMI+2+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d05b1ae6e3so30464445ab.0
        for <linux-can@vger.kernel.org>; Sun, 09 Mar 2025 03:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741517182; x=1742121982;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eco3k+TBsDkbmpqvhJ0sYzrtK8q7foQl94kdUFDByJQ=;
        b=GbcvINjFTNDJVc2dATsD6lLZdi1FgycTgnAAZhZ2hykqT2MWEyKv6qS4H+r0MeBXjh
         YQwJ1wIF+iewmmhc1TwzHawZoJtYSLnzn/re1DXdleRFk7TpbmJ+sq2/0HpYScJHqZo2
         fsJfqJ/5GH6gMp5NlQfMOpyIrK4XG9Jb2RBXI9LvyA2BdJSUAmCx7YxybSwGXr3n/EIR
         6UeyJ41IsgivoDy1x646S//CzXsnLmzYn5QCfuGob400ljZkdUlpiMKU5QqFdbBjGhUJ
         TlAnqx4S+uJT0h0rar03i9mbecTokbS3IJSYX0xAy8ndvpBpen0SafB8ReJOHBp2bsqQ
         LrRQ==
X-Gm-Message-State: AOJu0Yz7MXBkMIOX5jqC7/SaLLVbV9bZoSGkFgSVumbKtrUkwYqvVRwo
	9knG9tef514btYCLTqORdFhWOo4fZ/8QV4cXkg+8/VMocRcRHmZGCnbHCQX/DSbhjCIzPBKVLWM
	crLHcNI0nBvgHfWWegTX7n+eHZTxXPCumIrUx8e+HJIEf4MmT+N5M/6j4mA==
X-Google-Smtp-Source: AGHT+IHXNtwZ3elpyiLwduLxCpHFyTJc4L8eQ/csKiv/3aVcqzCU3ghy5QLbu6JvNnz1rMIkZXlGG7QXOpuUO4MorT5peQ9+Fj6I
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180c:b0:3d4:276:9a1b with SMTP id
 e9e14a558f8ab-3d441a06d98mr94835815ab.16.1741517182016; Sun, 09 Mar 2025
 03:46:22 -0700 (PDT)
Date: Sun, 09 Mar 2025 03:46:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cd717d.050a0220.e1a89.0006.GAE@google.com>
Subject: [syzbot] [can?] KCSAN: data-race in can_send / can_send (5)
From: syzbot <syzbot+78ce4489b812515d5e4d@syzkaller.appspotmail.com>
To: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mkl@pengutronix.de, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0f52fd4f67c6 Merge tag 'bcachefs-2025-03-06' of git://evil..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12d12a54580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=523b0e2f15224775
dashboard link: https://syzkaller.appspot.com/bug?extid=78ce4489b812515d5e4d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eb0d7b540c67/disk-0f52fd4f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/51c261332ad9/vmlinux-0f52fd4f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/38914a4790c8/bzImage-0f52fd4f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+78ce4489b812515d5e4d@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in can_send / can_send

read-write to 0xffff888117566290 of 8 bytes by interrupt on cpu 0:
 can_send+0x5a2/0x6d0 net/can/af_can.c:290
 bcm_can_tx+0x314/0x420 net/can/bcm.c:314
 bcm_tx_timeout_handler+0xea/0x280
 __run_hrtimer kernel/time/hrtimer.c:1801 [inline]
 __hrtimer_run_queues+0x20d/0x5e0 kernel/time/hrtimer.c:1865
 hrtimer_run_softirq+0xe4/0x2c0 kernel/time/hrtimer.c:1882
 handle_softirqs+0xbf/0x280 kernel/softirq.c:561
 run_ksoftirqd+0x1c/0x30 kernel/softirq.c:950
 smpboot_thread_fn+0x31c/0x4c0 kernel/smpboot.c:164
 kthread+0x4ae/0x520 kernel/kthread.c:464
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

read-write to 0xffff888117566290 of 8 bytes by interrupt on cpu 1:
 can_send+0x5a2/0x6d0 net/can/af_can.c:290
 bcm_can_tx+0x314/0x420 net/can/bcm.c:314
 bcm_tx_timeout_handler+0xea/0x280
 __run_hrtimer kernel/time/hrtimer.c:1801 [inline]
 __hrtimer_run_queues+0x20d/0x5e0 kernel/time/hrtimer.c:1865
 hrtimer_run_softirq+0xe4/0x2c0 kernel/time/hrtimer.c:1882
 handle_softirqs+0xbf/0x280 kernel/softirq.c:561
 run_ksoftirqd+0x1c/0x30 kernel/softirq.c:950
 smpboot_thread_fn+0x31c/0x4c0 kernel/smpboot.c:164
 kthread+0x4ae/0x520 kernel/kthread.c:464
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

value changed: 0x0000000000002b9d -> 0x0000000000002b9e

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 23 Comm: ksoftirqd/1 Tainted: G        W          6.14.0-rc5-syzkaller-00109-g0f52fd4f67c6 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

