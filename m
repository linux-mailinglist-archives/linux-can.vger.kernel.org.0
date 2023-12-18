Return-Path: <linux-can+bounces-96-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEBD8173B5
	for <lists+linux-can@lfdr.de>; Mon, 18 Dec 2023 15:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B26D8B23482
	for <lists+linux-can@lfdr.de>; Mon, 18 Dec 2023 14:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61DD129ECF;
	Mon, 18 Dec 2023 14:36:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6827C372
	for <linux-can@vger.kernel.org>; Mon, 18 Dec 2023 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7b7ccd6778fso149512239f.3
        for <linux-can@vger.kernel.org>; Mon, 18 Dec 2023 06:36:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702910178; x=1703514978;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7LnU8RknCJWsPsqm7RXDpRlRmyk9PFdTymemdD1BB0=;
        b=OzZhQG5y5ViQJXqClMjBmxgkqwjtJBJcX4eqWVGOOZzZuiZHt+HvMZfdzYlmYv3gkZ
         Ti+dMij7vFSSQC1IYTli4S2zYltym7vg4K8J8U+Nchd2IGx5QsvzuAMITeTyreyA4/Qr
         u1XIcrl3EwUk3MzVfTXU/tu2dxmB5rNF482zzuCvxnlLV+gEwdmTD0HKwbRPbftwNNhC
         E5yv09w04wwe7xlDGnf0fNx9fTdfR9PUwh8ah2OLIySl8mhGnL0WYZAOMKl6g9nBik1p
         ESNwvV5Y3vj7Zjd0S6+jbZzRIWD8MaO2Hfeacf9c7tY2LLu+qcprZO2P1nwJSse9spmq
         8AXg==
X-Gm-Message-State: AOJu0YyzJauA0ii+hix7Mt9z/w9wo0oPdNJxRKj6DcQlfznuvEiKSDoE
	8060UDRFpjHihYW8KfTkzHaKBbDJY3pcV44weop+yV66+ZhO
X-Google-Smtp-Source: AGHT+IFkNLsPR1axQYWCJ+SpPnOFsw/t4pfNw4EGH7RocShupcn9OymSX8sxcFLnEQuyCg/HvO19Z6BN6qQXhx9SP+LRAN3o0G5o
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:da01:0:b0:35d:70c7:4c5c with SMTP id
 z1-20020a92da01000000b0035d70c74c5cmr528892ilm.6.1702910178612; Mon, 18 Dec
 2023 06:36:18 -0800 (PST)
Date: Mon, 18 Dec 2023 06:36:18 -0800
In-Reply-To: <0000000000009393ba059691c6a3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047de92060cc9ace1@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in j1939_session_get_by_addr
From: syzbot <syzbot+d9536adc269404a984f8@syzkaller.appspotmail.com>
To: Jose.Abreu@synopsys.com, arvid.brodin@alten.se, davem@davemloft.net, 
	dvyukov@google.com, ilias.apalodimas@linaro.org, joabreu@synopsys.com, 
	jose.abreu@synopsys.com, kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@rempel-privat.de, mkl@pengutronix.de, 
	netdev@vger.kernel.org, nogikh@google.com, robin@protonic.nl, 
	socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com, 
	tonymarislogistics@yandex.com
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
can: j1939: transport: make sure the aborted session will be deactivated only once

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=d9536adc269404a984f8

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos

