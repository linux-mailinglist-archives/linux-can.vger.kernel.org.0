Return-Path: <linux-can+bounces-3237-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6E4A729E6
	for <lists+linux-can@lfdr.de>; Thu, 27 Mar 2025 06:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE1018860F8
	for <lists+linux-can@lfdr.de>; Thu, 27 Mar 2025 05:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA721BC07B;
	Thu, 27 Mar 2025 05:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="r45snMuL"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-66.smtpout.orange.fr [193.252.22.66])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAFC61FF2;
	Thu, 27 Mar 2025 05:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743053603; cv=none; b=rip6NH/Ak0MISi+j+iuIfSm8FlZlbADNBodbFzTWmlunfuhbxkQwlnD7is1wENAmrXxwfIq/XpXodKE7i+izstAP4eNnq4ah+F0b/9bXmK/s51ke/CSRLog/P0J4/t/q5QnSplM9OD+gXRynHmyJnihoJpl5hrZ5JalFiKjzxwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743053603; c=relaxed/simple;
	bh=tLUAS9dGI+wo8uk4MrNiJXSGrRZP6Eeua4jIfpiG9jI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Y4y8foSpSbT6bBINyGS3riJNTVjFk4IXA3fKJhddCu9McVuhlmo7S2HSkH2Mx8hmSNpm6Ry+KnERL7HeW7RgH3OrihiPKnXvUOfGiGBUY7PZ0+iWL1xjIsIwcc/U0yGn20ivKclyMtANZX8gk3nx8pritDOz8dwc6yr7NHFafbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=r45snMuL; arc=none smtp.client-ip=193.252.22.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id xfrVtkf7to3Z8xfratsj2c; Thu, 27 Mar 2025 06:33:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743053592;
	bh=ltVEfqyIvF8S0cNST+rZk3ktk+yuzbGynB5Pi/65nTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=r45snMuL7CiY6LxMtPFNFUTYX0KDde+FDgVOYBx/XBUhHxGQOPzxEmzUoThZJ+368
	 uDBig2YWse19S7gC35e/qd4XfaLDTekEXEQv01WFiMvuxC+NpjKIbQ53e2IumVoe8T
	 90HNI2pwTu9Lq4GNhBPq21EHQM5JpCUOW8jN4uc6d6MVAaT867z2DnL5PCI7B9+M0R
	 wk1paxkk0Nbi721cGaWBbVuJ+G9Krq5FVclEMPgvEAu1SuJmGiFvDkONF0cX7jSyZP
	 BHygXm4WPzJM3BSOXhWc42J/Kl0ikls7n2BxM/beC4wgzxvbBv9GPv/1SJZ/3ZJ/l2
	 KtcCG4N0ee2qg==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 27 Mar 2025 06:33:12 +0100
X-ME-IP: 124.33.176.97
Message-ID: <713f8ca1-e406-421e-89b3-17458995ed1c@wanadoo.fr>
Date: Thu, 27 Mar 2025 14:33:04 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [can?] [usb?] KASAN: slab-out-of-bounds Read in
 ucan_probe
To: syzbot <syzbot+79340d79a8ed013a2313@syzkaller.appspotmail.com>
References: <67e46af0.050a0220.2f068f.000e.GAE@google.com>
Content-Language: en-US
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mkl@pengutronix.de,
 syzkaller-bugs@googlegroups.com
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <67e46af0.050a0220.2f068f.000e.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/03/2025 at 06:00, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    245aece3750d MAINTAINERS: Add myself as a riscv reviewer
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> console output: https://syzkaller.appspot.com/x/log.txt?x=1241643f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ef948fab17fe83a5
> dashboard link: https://syzkaller.appspot.com/bug?extid=79340d79a8ed013a2313
> compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: riscv64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10de2804580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14bd4198580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-245aece3.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1570230830d5/vmlinux-245aece3.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a3c2191c4291/Image-245aece3.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+79340d79a8ed013a2313@syzkaller.appspotmail.com
> 
> usb 1-1: ucan: probing device on interface #0
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in sized_strscpy+0x2a2/0x2cc lib/string.c:182
> Read of size 1 at addr ffffaf801ba334c0 by task kworker/0:1/9

This is already fixed upstream in commit 1d22a122ffb1 ("can: ucan: fix
out of bound read in strscpy() source")

Link: https://git.kernel.org/torvalds/c/1d22a122ffb1


Yours sincerely,
Vincent Mailhol


