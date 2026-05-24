Return-Path: <linux-can+bounces-7690-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Anu/KohIEmqYxQYAu9opvQ
	(envelope-from <linux-can+bounces-7690-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 24 May 2026 02:38:32 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E63B65C0F93
	for <lists+linux-can@lfdr.de>; Sun, 24 May 2026 02:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE5BA300EFBD
	for <lists+linux-can@lfdr.de>; Sun, 24 May 2026 00:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B0A1A2C04;
	Sun, 24 May 2026 00:38:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5545190473
	for <linux-can@vger.kernel.org>; Sun, 24 May 2026 00:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779583109; cv=none; b=klGhpgRgTh3BOjsE6Y3BEOjhezMe9nQAd1LwoQKOSPpe9sRPXJiNvg4GHiwvx6nOg4SBttyjdJCs5XGWkNIYIzDJJZtALZEKDlu/vMxmkP9zPxZYt9OrxCY+Cqn7olWNEvNr7osn+dOTORLrXHE70NyFTF6KstbydoSj+q4s7Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779583109; c=relaxed/simple;
	bh=GvkT2b/Lwj7ULEbYXeECYAuzWvpDi+pmm8MUTzAXzGc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=atyJVfqXCmx1WFlXYtnhDZJdrPO8UTbbmRc3fcjb8nkgrfY/zU6hkcr/j+c4mqzeWLEGNHpX6PBJ2/gMwjYnPzp9bJklriNiuwirmg60q503BE/lhIWishYH0Qte4HqCCFBc3EITxz6Ke/tzXOAKB6tOnpsPxqlW2TFosmWpmdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7e5e92fbe1fso5118880a34.1
        for <linux-can@vger.kernel.org>; Sat, 23 May 2026 17:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779583106; x=1780187906;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/vugJl2FiEz7KDIUBOUS0iitY4xYJhfPai9Y7x5gRnw=;
        b=X3b1+URR21HMF4qV9TAODZSwon/sCb0lxjE/kMKQBHSMWLpoWPBjVUWTJ+Ir3glcoI
         V5GFLyk8eCFwQimHtZe0vgEIGDs3Ya6eY8nbLYbmyj1UJ1bf7UQ2QptXW4S/9W72i+Tt
         VCvyX78xpwTVO5Xq8SjnNb9Upd1tXKXPjNhhexTT+iRKZ4zVU/qNe40rdYt7C/7Z8HKj
         fRSjGk/kyMYGAMlu56HatOouNHAk0T1YLV/Bz/ZeONDHA50US9FwknfgqpewP7xeFpmo
         h92iBM6Az/E6ETWhbU89SB/CeHgsTvpAr71VuWtCMnYsStEsd8UCNClsHG+WaGQysQpS
         G3YA==
X-Gm-Message-State: AOJu0Ywu8DCCxPN6qLHkVJfC2cA5qLG7IttoIesJgN63du0njYFAqg2f
	V7Ga7aIxorkzFtnwBUeqwisOZ77+yXqW+kHlVPHjR49NYkSLVkfC5Hrc5KgSTcu1TRnFhKt6UtI
	nQp3yKH2+N54+tDKHgHoYXI8h5gVqhsRL8yqGZ+7atp6mI4zQzlLIMIBD3Ug5RQ==
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:8183:b0:69d:8700:c925 with SMTP id
 006d021491bc7-69d8700db06mr3822474eaf.8.1779583106781; Sat, 23 May 2026
 17:38:26 -0700 (PDT)
Date: Sat, 23 May 2026 17:38:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a124882.050a0220.30ba69.0009.GAE@google.com>
Subject: [syzbot] [can?] general protection fault in can_rx_unregister (2)
From: syzbot <syzbot+8ed98cbd0161632bce95@syzkaller.appspotmail.com>
To: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mkl@pengutronix.de, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a834c6344141a58b];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7690-lists,linux-can=lfdr.de,8ed98cbd0161632bce95];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,goo.gl:url,storage.googleapis.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E63B65C0F93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    4b4362973b6f Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15e86d96580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a834c6344141a58b
dashboard link: https://syzkaller.appspot.com/bug?extid=8ed98cbd0161632bce95
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111f147e580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17942ac8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f69f86c90ee5/disk-4b436297.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/79fa7b33aaab/vmlinux-4b436297.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ef080156d0de/Image-4b436297.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8ed98cbd0161632bce95@syzkaller.appspotmail.com

bond1: (slave vxcan3): Setting fail_over_mac to active for active-backup mode
bond1: (slave vxcan3): making interface the new active one
bond1: (slave vxcan3): Enslaving as an active interface with an up link
Unable to handle kernel paging request at virtual address dfff800000000005
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000005] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1]  SMP
Modules linked in:
CPU: 0 UID: 0 PID: 4947 Comm: syz.0.86 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : can_rx_unregister+0x124/0x560 net/can/af_can.c:537
lr : can_rx_unregister+0x11c/0x560 net/can/af_can.c:531
sp : ffff800096267a40
x29: ffff800096267a60 x28: dfff800000000000 x27: ffff700012c4cf5c
x26: ffff0000d755ae48 x25: ffff0000c5c9ec00 x24: 0000000000000000
x23: ffff80008597d660 x22: ffff0000d9aa8000 x21: ffff0000cc740000
x20: 0000000000000028 x19: ffff0000cc740108 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 00000000ffff8000 x13: 0000000000000001 x12: 0000000000000004
x11: ffff700012c4cf30 x10: 0000000000ff0100 x9 : 0000000000000201
x8 : 0000000000000005 x7 : ffff80008594bef0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff80008594ba58
x2 : 0000000000000001 x1 : ffff0000d5110000 x0 : 0000000000000028
Call trace:
 can_rx_unregister+0x124/0x560 net/can/af_can.c:531 (P)
 isotp_release+0x500/0x9d8 net/can/isotp.c:1232
 __sock_release+0xa0/0x1d4 net/socket.c:722
 sock_close+0x24/0x38 net/socket.c:1514
 __fput+0x340/0x744 fs/file_table.c:510
 ____fput+0x20/0x30 fs/file_table.c:538
 task_work_run+0x1c4/0x254 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0x10c/0x17c kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 arm64_syscall_exit_to_user_mode arch/arm64/kernel/entry-common.c:88 [inline]
 el0_svc+0x18c/0x260 arch/arm64/kernel/entry-common.c:741
 el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:759
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:594
Code: aa1803e2 97ffff00 d343fc08 aa0003f4 (387c6908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	aa1803e2 	mov	x2, x24
   4:	97ffff00 	bl	0xfffffffffffffc04
   8:	d343fc08 	lsr	x8, x0, #3
   c:	aa0003f4 	mov	x20, x0
* 10:	387c6908 	ldrb	w8, [x8, x28] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

