Return-Path: <linux-can+bounces-34-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E70D7F15CA
	for <lists+linux-can@lfdr.de>; Mon, 20 Nov 2023 15:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3003B219F2
	for <lists+linux-can@lfdr.de>; Mon, 20 Nov 2023 14:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E761B277;
	Mon, 20 Nov 2023 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677C1139
	for <linux-can@vger.kernel.org>; Mon, 20 Nov 2023 06:35:21 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5be39ccc2e9so5958606a12.3
        for <linux-can@vger.kernel.org>; Mon, 20 Nov 2023 06:35:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700490921; x=1701095721;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7LnU8RknCJWsPsqm7RXDpRlRmyk9PFdTymemdD1BB0=;
        b=Cm18fdx8Py2eg+xSihQaYflFuxAiPsHo4aQ3+LD1/4Smri8hX0KaIklmFvQoCMUJ08
         mCVu3goRZgyu0gi33ahSR35FbrJsnoLC54n1SBsLM0jpnieivXTWW7CYr2dql24ZXO6S
         ULzV0r/2JifQdhCqEw8TGa5wKzTXi/oOHU7XRq7r3bZRmjFIbfN5TlpX50ysJ5CHCZLU
         uZgxVHrOa5SOnFmf3o3PU6LEBUlLUYAu6zJRZ+r1kMwgMfUXe5CGMHCYVgmZdxrI0e5h
         VUYkh+aJp2sZjt+os1RenwfA//6+5RvUawUxti0B0s+CFA9qTnIoMTHksqpjmAtXHZmy
         WRtg==
X-Gm-Message-State: AOJu0YwhT9aa0ujc3zN/5OfQCGqkcUP369yDh20gcegdL/AdSA3sOhb9
	98ZHObJI5R3ytvgNqVT3Mdldfi/DDm/B7gPasWw1KRGVtIGa
X-Google-Smtp-Source: AGHT+IEzo56JbmoqVwXpNg8mySCpYTtfjo3yW4Qe9XqQZVtkbrSYD8LRgMtcpz+jO1iIYLRpugHW71s2+YOd//5V4KN6QrJvxIwu
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a65:6897:0:b0:5c2:1816:24c5 with SMTP id
 e23-20020a656897000000b005c2181624c5mr1598710pgt.10.1700490920919; Mon, 20
 Nov 2023 06:35:20 -0800 (PST)
Date: Mon, 20 Nov 2023 06:35:20 -0800
In-Reply-To: <0000000000009393ba059691c6a3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000490858060a96651c@google.com>
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

