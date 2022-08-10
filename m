Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B8858E4E5
	for <lists+linux-can@lfdr.de>; Wed, 10 Aug 2022 04:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiHJCf2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Aug 2022 22:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiHJCfV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Aug 2022 22:35:21 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6EF19029
        for <linux-can@vger.kernel.org>; Tue,  9 Aug 2022 19:35:20 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-32868f43dd6so129234427b3.8
        for <linux-can@vger.kernel.org>; Tue, 09 Aug 2022 19:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidbol-es.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=xfIkgKrMM5KJeCfvh9EFbUf2BK2JXXYkKgemhBLMZbY=;
        b=xCAC8No8H8IDrKRAHzh1zWHG6/eKLWNrEHxX8J5mV/9R8ZsJcSNbuEBgdSI7WEQTG6
         ANAHQOKuAHf+wXbFBEMO7Pc8yrKlplz9nYMfRKMCH+sZpNehZ9KJKfeDDnc9bM2wAy6b
         wm5FqfdcLiKuCsgvjKrW45XCxMHIPWvSAdjQht1xD60xSMedq+Ys1+WJZLFb+Kf0c5n/
         0pNWqm3EcD00jTcO1idAtT7/tvAGP0aD8nRxkrHTwt3vWHJdtkRVIpqbh5vmuSdtAK4D
         ARy/cz7+LRgRVQMHfrc6Q/KIoWtcpTBKIHv/YXrjPVFSMMujxBmaMiXPGPdojhQ2mbvu
         HvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=xfIkgKrMM5KJeCfvh9EFbUf2BK2JXXYkKgemhBLMZbY=;
        b=RVN5ogqqsMncpNToQNf2C/K7K8QtxQ9ZtnzSx/3G1pgo/yGFv2cJX23iW++wkm07pA
         24OpFVqmH7KZRgako7pkZa8/sQ21mv+aJP4rx6KRilHgPN2Xose+HsxBibLyqBUTGRK7
         MTf3Mvu6yHCBSi6C9lBi4uVhsRR7TE3xjeoWfDXOFrDT2189KLPrVeocv+J/4kWqQIkZ
         HjjZ1X9+Sw58A3SByGBN0HbX8d0rM4AnyjRbBsmV3GJmJzEe2HovNNNCJk4h6HzSZzHv
         FnbxuFzit6g9XJIgOaY+tdybYjsodCd4b9aht1NyVEhPktvJT+WtEdtGBN0w+6nW9+S5
         SjKg==
X-Gm-Message-State: ACgBeo1d9fgu/KIRq4Z9tS7Ix6vNjLLMgHbrULTCvGMXH0YGUAFLxE1O
        hGU3rCGlaZFb3x0At98Ry85Otv5px3HqbQWBj/6/OugFnOUirQ==
X-Google-Smtp-Source: AA6agR5aoCBbVsO1nF3bbbdb2x4DZpDlKbGYlFJL4bT7Rd4TdhmbFe/woKDXX0Ytt89TBlC77CouorjlQzj8uBGDb38=
X-Received: by 2002:a81:9904:0:b0:31f:496d:a6c with SMTP id
 q4-20020a819904000000b0031f496d0a6cmr28138782ywg.133.1660098919752; Tue, 09
 Aug 2022 19:35:19 -0700 (PDT)
MIME-Version: 1.0
From:   David Boles <me@davidbol.es>
Date:   Tue, 9 Aug 2022 19:35:09 -0700
Message-ID: <CAMgOUGpGEUQgLgAQmYbn-UdWXCkC7kRqdhW-mfg=e2gq9QfqRQ@mail.gmail.com>
Subject: PCAN and SocketCAN Questions
To:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello everyone, I'm new to both SocketCAN and mailing lists so please
let me know if I'm making any faux pas or haven't correctly RTFMed! I
heard this was the correct place to ask questions and I have a few
that I haven't been able to find answers to.

All my testing so far has been done on Ubuntu 20.04 with
5.15.0-43-generic and PCAN-USB( Pro) dongles and PCAN-PCI Express
cards.

Question 1: I've noticed that frames can get silently lost if my
application doesn't read from the socket frequently enough. This also
happens if I'm simultaneously dumping frames with candump (the "lost"
frames do show up in candump's output). Increasing the socket receive
buffer size with SO_RCVBUF allows more frames to be stored before new
ones start getting lost. Is there a recommended way to detect this
happening so that my program can fail noisily?

Question 2: I'd like to be able to send frames without other receivers
on the bus to acknowledge them. The one-shot option seems to allow me
to do this with my USB dongles. What's the difference between the
one-shot and presume-ack options?

Question 3: I'd like to have as little latency as possible and I'm
assuming using PCIe cards would be beneficial over USB. Unfortunately
my PCAN-PCI Express card doesn't seem to support either one-shot or
presume-ack; is that a hardware limitation or a driver limitation? If
it's a hardware limitation, would anyone be able to recommend a
low-latency, full-featured option for CAN on traditional x86/64
desktops?

Thank you in advance!

David
