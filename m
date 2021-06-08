Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B90C39FAB4
	for <lists+linux-can@lfdr.de>; Tue,  8 Jun 2021 17:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhFHPav (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Jun 2021 11:30:51 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40907 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhFHPau (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Jun 2021 11:30:50 -0400
Received: by mail-lf1-f67.google.com with SMTP id w33so32752192lfu.7
        for <linux-can@vger.kernel.org>; Tue, 08 Jun 2021 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xT1A2zX5P+BjQO3UCmhtHEAfietKFU3xP0WbjwTvUvw=;
        b=vR+OAPyLLjc9XC2gQqVP1rKSqq7vY1OckJTh9hXYaULG3lNd6KRpkgZGYav8If/Ls3
         dckwlz/Fr+wJGR/wWCqB5/nvB7T7je2KuKPwN/PBlpLjmEusg89qRGWOCTHD9eNGhpO5
         WBIB9uE1nw3bPGGUc8reTTcB7/zbajGjQA8BGX6VhXQJTbGV44y+DtGaZlrHpnS0lhen
         kQ1ya/tCkZ8jnMvgmZ8WW0WxAVI/VxticEGcV7ZVhUJ0IDtmk7Pl0Fhct3KJJjBiYcPy
         lwxTF/mTEQNSTCxdjnifPHY4WER0Isxr8sucmolDOloRIWpiWu2Aqm6kKgRQfJi220SZ
         6+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xT1A2zX5P+BjQO3UCmhtHEAfietKFU3xP0WbjwTvUvw=;
        b=D6U+c2gzywsqqS/rD//f2Te+PseAfafnyLKsbANvLDZZJU7AO2FFP88HOaACL8y4eL
         ASnpLTLah/2nBM2P7Xeu6sLH1QUJgB3325maFi/t+wPfZC9BttxbNWd/TRZYvBNwAUHB
         JGt9RAmRHYsgrf1fzEK7T4s2ghgNtMTT3ALzIu5pmjJH/0eJ9Jf8PQsmkz6uXk9yF9yw
         8RsoISzZa6uquhqO5QtmlO6gEBDho49sYLeRdOZefw8aAc2ZQBqL0Y+DbYrtsILDYGaO
         xJi3RBa3efhLh01iARS9QYXxL4zd4qoHU9ACEMZnUtIVDBiVfhxX/M2/GWhNamQr62B+
         05dQ==
X-Gm-Message-State: AOAM530nrTEpTEErd5AbSfKIskjA/aZNp/mQ3o0IQCvhXQWJZBKLcPU8
        6ytkunN2OZ9OyXoJjtV5Df2JatEDCyjGL9w64SSRYPiZ5FdCrklL
X-Google-Smtp-Source: ABdhPJx4qdaRkFPUEDfPXipLkG+RgZPeml2iUZ4OEtS4KhYpYSOq3uADYGgDGtJfwe2lxWfImiJcEMAdZRC6PIa1xSw=
X-Received: by 2002:ac2:46f5:: with SMTP id q21mr6431796lfo.518.1623166076160;
 Tue, 08 Jun 2021 08:27:56 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?R=C3=A9my_DZIEMIASZKO?= <remy.dziemiaszko@smile.fr>
Date:   Tue, 8 Jun 2021 17:27:45 +0200
Message-ID: <CAEWvZg2rvR=9kE_wcm-KtzMvDtnqTEXSLF56zrB=3TgqZbEs1w@mail.gmail.com>
Subject: How to statically set J1939 addresses and names
To:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

I need that my applications do not care about J1939 node addresses but
directly bind / connect to socket based on node name only and the
kernel takes care of the conversion to addresses.

I know this is possible if addresses are dynamically assigned through
the Address Claiming protocol that is implemented in the kernel. The
kernel keeps track of its own address and name as well as the
addresses and names of other ECUs on the network and convert name to
adresse when requested by the applications.

But I don't want to use the Address Claiming protocol. I want to
statically set all addresses and names.

Is there a way to assign J1939 addresses and names to a CAN interface
without using the J1939 address claim protocol?

I found in old j1939 kernel documentation something like
ip addr add dev canX j1939 0xXX
ip addr add dev canX j1939 name 0xXX
See https://www.spinics.net/lists/netdev/msg162350.html

But in the latest j1939 kernel documentation I do not find any
reference to these commands.

Thanks for your help
--
R=C3=A9my Dziemiaszko
Tech Manager
Smile Embedded & Connected Systems
