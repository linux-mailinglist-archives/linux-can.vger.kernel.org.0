Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C05761AA9
	for <lists+linux-can@lfdr.de>; Tue, 25 Jul 2023 15:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjGYNxu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 25 Jul 2023 09:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjGYNxs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Jul 2023 09:53:48 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9771FEB
        for <linux-can@vger.kernel.org>; Tue, 25 Jul 2023 06:53:46 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-39cdf9f9d10so9168949b6e.3
        for <linux-can@vger.kernel.org>; Tue, 25 Jul 2023 06:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690293225; x=1690898025;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=try7kLiqOvWBbDWNv3AsjzJNZ1pHNvllo2yNmM+PfCo=;
        b=kNGrt3kaw7fPtL3WQYwz9CwM9JmGKWW568fIviyY06qz1XhMwW7A3vvUEguR8bFPFX
         qeB4ij3webYkHMLmgFPH8dGLAMmVKBmAuQY8BgVq7w5V//lqY8mNPD4Nov/ielEnTTBE
         Ctq8aqeq4RZ3lSvW3O2SY7bg7MZAa5NjxnyzrSyLdzWzXF4ucsUGeRjNQa+EQcAimn3y
         nFHrDJfoWBsz+Exan3wUcspNRBLPfKKZcgKJZt+seGpMdUJOsZMcFiNi5+CIsMlUPRyi
         VC7BkRVgPqupKrNRXq/5okyZ6cjVQxcg2GGaYcNSmc+hQnoB4g8jXHFXVTz9JQYtIkGP
         RG9g==
X-Gm-Message-State: ABy/qLYSW2j6i8onVSeLN8JsJeFq0N6hIeezWOinqR0LCPEyZfWWFHXi
        1pR1quSVRh6ER5E7MCoI2GbOrHi9y19M0nemrM5ovp3yOh+C
X-Google-Smtp-Source: APBJJlFTc3F/yCQIEjusQ5xmHQUk99lac6DPdjFsUr1VsAB/ucUksQNNIo1zzodCuXIkwCozJhHXL8R9/JQR1zDBvQAjEPB97Uv/
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2005:b0:3a3:8c81:a887 with SMTP id
 q5-20020a056808200500b003a38c81a887mr25942704oiw.6.1690293225794; Tue, 25 Jul
 2023 06:53:45 -0700 (PDT)
Date:   Tue, 25 Jul 2023 06:53:45 -0700
In-Reply-To: <0000000000009393ba059691c6a3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a33ca0601500f33@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in j1939_session_get_by_addr
From:   syzbot <syzbot+d9536adc269404a984f8@syzkaller.appspotmail.com>
To:     Jose.Abreu@synopsys.com, arvid.brodin@alten.se,
        davem@davemloft.net, dvyukov@google.com,
        ilias.apalodimas@linaro.org, joabreu@synopsys.com,
        jose.abreu@synopsys.com, kernel@pengutronix.de,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org,
        nogikh@google.com, robin@protonic.nl, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com, tonymarislogistics@yandex.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This bug is marked as fixed by commit:
can: j1939: transport: make sure the aborted session will be

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
