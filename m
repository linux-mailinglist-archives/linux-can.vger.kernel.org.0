Return-Path: <linux-can+bounces-6294-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBOWGtTVdWn0IwEAu9opvQ
	(envelope-from <linux-can+bounces-6294-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 25 Jan 2026 09:35:32 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E78A78004B
	for <lists+linux-can@lfdr.de>; Sun, 25 Jan 2026 09:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5924E3001328
	for <lists+linux-can@lfdr.de>; Sun, 25 Jan 2026 08:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998BF248F4E;
	Sun, 25 Jan 2026 08:35:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DA81482E8
	for <linux-can@vger.kernel.org>; Sun, 25 Jan 2026 08:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769330129; cv=none; b=P7JHvZHL585HGR2Zt/Kk0+zR/BQcvZeVD9vtxeVYg7fUimKCMn4NFap7NlZuCf+iDnLwQ90dQD2On4Hxhx7iCPctIrCKWQVVjxXHMbxXHmkVkhXEoSBDwcdK1ggjLbTOOJRz1M6FkTjc2HzK+Z+GSRAULpAnVe4u2ZKATAJ0jog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769330129; c=relaxed/simple;
	bh=Az+is/AFn37WkDbsnSQSI08Mp9H1ubJiUScdlsH+kIE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=anm6bPqxABGctPHhfc7fjG5La4MR9b93YphFplNi72rqrARYkS1BH/bWedPEeVDWFM9xbFkLErTHtWUcep3gcF4NT2+8GOHIHf6dyHVdCcuYsUtY3SuJOjFwAbsqysedmng8UCUTNXdLnOxr/WBKmZsSzTYbKjO1Tucv31S+jZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-662ca3cb667so4086266eaf.2
        for <linux-can@vger.kernel.org>; Sun, 25 Jan 2026 00:35:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769330127; x=1769934927;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HJVimj3LwoMN/4DXPtWP7/sOCmqjKaZSVowjkdE5ukU=;
        b=qQjl+YWhYtyA52Dxf8jTVQN5tAJyolmThoDYZezolk+vfg6F1z7NnkltV7B3HPV/Fs
         tFx+PaZQKBtQsqkG6AdwZrBR5jY+8pEDkn3PPWznt8OcQqZCaq5pzVYLCXYAnelbw0cS
         SuMW6m8dhiBOah3zm9qjJVk0nOVcSqb92cBSrPxwFzxNte4II9DCDTlWgefFj1kmUhdz
         z+yuJH8nylUUbCO8bP/0zNnbvMDry8A5KH53INnbhvin0Udl0RXgX4ZspMuQ7aOkr8+u
         Bj0+3PY6Ib5MuqySkQ+SxE5ad08GR0djficL/IX6NEltDld/UblLpUT/kzenxZprZgcP
         ja8Q==
X-Gm-Message-State: AOJu0Yxr4oBBQBS153M5XoM1DM8OsSmMLin8hHjsZhixezkptUuBKra/
	2GWvS7ez99tODMzbiqyiRZPih0tWTbvwzMEcS5gMaqKB8P9hx4Aid6abUwfYfMtlDhztvhmRfTu
	aPI5uulDR4jB7qLKslIdkzfd/FDiWXP5S27KO42oVI4HBjtAHWjLtnFi/Rg/H/A==
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c83:b0:662:c1a7:e165 with SMTP id
 006d021491bc7-662e04022e4mr575732eaf.30.1769330127040; Sun, 25 Jan 2026
 00:35:27 -0800 (PST)
Date: Sun, 25 Jan 2026 00:35:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6975d5cf.a00a0220.33ccc7.0022.GAE@google.com>
Subject: [syzbot] [can?] KCSAN: data-race in bcm_rx_setup / bcm_rx_update_and_send
From: syzbot <syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com>
To: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mkl@pengutronix.de, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=676c6f0212d0c041];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6294-lists,linux-can=lfdr.de,75e5e4ae00c3b4bb544e];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,storage.googleapis.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E78A78004B
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    24d479d26b25 Linux 6.19-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=153a9b9a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=676c6f0212d0c041
dashboard link: https://syzkaller.appspot.com/bug?extid=75e5e4ae00c3b4bb544e
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e47d2b960e97/disk-24d479d2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/75c59e1fc76a/vmlinux-24d479d2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e42579adf478/bzImage-24d479d2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com

UDPLite6: UDP-Lite is deprecated and scheduled to be removed in 2025, please contact the netdev mailing list
==================================================================
BUG: KCSAN: data-race in bcm_rx_setup / bcm_rx_update_and_send

read to 0xffff88811adccc40 of 16 bytes by interrupt on cpu 1:
 bcm_rx_changed net/can/bcm.c:500 [inline]
 bcm_rx_update_and_send+0x37f/0x420 net/can/bcm.c:553
 bcm_rx_handler+0x2b0/0x580 net/can/bcm.c:739
 deliver net/can/af_can.c:575 [inline]
 can_rcv_filter+0x3c6/0x4f0 net/can/af_can.c:636
 can_receive+0xfb/0x1c0 net/can/af_can.c:662
 canfd_rcv+0xed/0x190 net/can/af_can.c:705
 __netif_receive_skb_one_core net/core/dev.c:6152 [inline]
 __netif_receive_skb+0x120/0x270 net/core/dev.c:6265
 process_backlog+0x228/0x420 net/core/dev.c:6617
 __napi_poll+0x5f/0x300 net/core/dev.c:7681
 napi_poll net/core/dev.c:7744 [inline]
 net_rx_action+0x452/0x930 net/core/dev.c:7896
 handle_softirqs+0xb9/0x280 kernel/softirq.c:622
 run_ksoftirqd+0x1c/0x30 kernel/softirq.c:1063
 smpboot_thread_fn+0x32a/0x510 kernel/smpboot.c:160
 kthread+0x488/0x510 kernel/kthread.c:463
 ret_from_fork+0x148/0x280 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

write to 0xffff88811adccc40 of 16 bytes by task 3847 on cpu 0:
 bcm_rx_setup+0x7c5/0xe00 net/can/bcm.c:1259
 bcm_sendmsg+0x1bb/0x4a0 net/can/bcm.c:1427
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x145/0x170 net/socket.c:742
 ____sys_sendmsg+0x31e/0x4a0 net/socket.c:2592
 ___sys_sendmsg+0x195/0x1e0 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0xd4/0x160 net/socket.c:2681
 x64_sys_call+0x17ba/0x3000 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 3847 Comm: syz.0.79 Not tainted syzkaller #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
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

