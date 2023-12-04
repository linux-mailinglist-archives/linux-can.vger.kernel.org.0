Return-Path: <linux-can+bounces-67-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAF48036E3
	for <lists+linux-can@lfdr.de>; Mon,  4 Dec 2023 15:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E92D1C20BBA
	for <lists+linux-can@lfdr.de>; Mon,  4 Dec 2023 14:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF2422F04;
	Mon,  4 Dec 2023 14:35:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D80C1BD
	for <linux-can@vger.kernel.org>; Mon,  4 Dec 2023 06:35:25 -0800 (PST)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-58dc5e3cd7bso5393898eaf.1
        for <linux-can@vger.kernel.org>; Mon, 04 Dec 2023 06:35:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701700525; x=1702305325;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7LnU8RknCJWsPsqm7RXDpRlRmyk9PFdTymemdD1BB0=;
        b=b7qKMte2sbWBQW1y/QCbO70C6OlZ7kcItvUPxu7vfx6/J7GU06zQXsuF8OLVwFUjXC
         0der0T8o8BXOcg3tto29kzLvaN82ceyit3/LKRFHX57n2t+pZAVfFSyT77e2MshvkhY4
         +CgsarhnY/gLdbCOTf6n+K2LyYU2YKsfFBu1QIH/4BRCZKdHBgbF8cAKhdoLoz1rdTM/
         x6HaoXAUlE3RueVUX3WhLOe3ELbO6c4NZaMj57ZQQazN/fE3WoPUbHkBozKXN9Y7rfFi
         6NMYWZad5F+2Lr4Z0D1nBVyF1bcyZqKR1BIprAl9LqTVV9jfxCKaZibrOQgc1p80AtPt
         M/mw==
X-Gm-Message-State: AOJu0YyGcd52XdjTKHkp0Myyftr99moycJLr88GKQXuJ/OjtovOQGTZS
	D+QKXmeTtap/FkxwwoaE6NE+ITh12SRJFKBb4fHAUu6kFQEF
X-Google-Smtp-Source: AGHT+IHT3NWz/uh6K0jGolZs7daejkq97Tqs4R/UZgXVTOfGS7B2im6mm2gusbDRj6n3heAiSw2fT9HRkL/yzzPbyEONKMNUWrjB
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:eb85:0:b0:58d:3c4b:ee40 with SMTP id
 d5-20020a4aeb85000000b0058d3c4bee40mr2648387ooj.0.1701700524964; Mon, 04 Dec
 2023 06:35:24 -0800 (PST)
Date: Mon, 04 Dec 2023 06:35:24 -0800
In-Reply-To: <0000000000009393ba059691c6a3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e04c2060bb007f9@google.com>
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

