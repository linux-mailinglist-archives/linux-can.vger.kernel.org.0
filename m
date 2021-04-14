Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0555035FB9C
	for <lists+linux-can@lfdr.de>; Wed, 14 Apr 2021 21:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349289AbhDNTXY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 14 Apr 2021 15:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhDNTXY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 14 Apr 2021 15:23:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98794C061574
        for <linux-can@vger.kernel.org>; Wed, 14 Apr 2021 12:23:02 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id g9so4908870wrx.0
        for <linux-can@vger.kernel.org>; Wed, 14 Apr 2021 12:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flodin-me.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=tzR+t8GgDghjelYcLhD32VGoNxLFzy7UWSpe6runfoE=;
        b=i5Jiw6ol0x6FfDE5sI8MQimbwD7xVp+aT8tnCC6aDR88YMB5sJgRhpXowOXL3jLE2z
         L6ZUWwEaZgvcps3zYSv8XUcM4Psa1VF63y8/7LV7esteDZZazYZArUHPESB0qFr3RNJ0
         LBFyx4/af2KhgkfHSaoUoLIFOjVqitt4XxgnVjNWzVrU9QOTcImN/1zaQLbj55LeqeTb
         nIMozUt/1a+UjHeiwGkTScGBgZhqg9WAOBuQR5CoKdEI5dS4AtqbRH95FJ3jZtGo1O9a
         0Y0QLJ9V9tontxUilUWNMmFMrmtUR81GTOc+mmr0OBzHxfIdWNvgmMSMRTclq+4aR9Y4
         1vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tzR+t8GgDghjelYcLhD32VGoNxLFzy7UWSpe6runfoE=;
        b=jeL0+n95QhESxiWKXIpO3+Dmc84xtfcd6gMNcy+jqpiOxN5HHpLPrJ3NsukjerKJ6L
         f8ZUKv7ftHz6Ro+Tgp37YxSq4YIlSTPncOnDlytK+qdHsextodBoFz6Ja/yT9EORhPfR
         NGkwUTrCAs7wH7s0eSmoHC7SzRZ0ZwTNV4dcaF9WfSkyVR753CKO2yM7ikl96yoNcfFz
         MX7GRELw5UYGaS/fQtdh350QJSRUImiJPaB/Yu3AfqtP95GnbYwPGtreiWhAaaX5cA60
         OMSu8Q7SakgFoY7m2Apdjj9592QOsldhqwdJ2U/M0k/8tP1S5WfODnEdstrIsba0RHiu
         vI8A==
X-Gm-Message-State: AOAM533L/jbVAoFXYTzJkIIlOMDdEdgAlG8yEp06jti+u5dJCFBg1vh1
        qxkfZIN5AMKibBLGLnLRBQn3FeUl8Y5pQZ3jIn72Jaupivg=
X-Google-Smtp-Source: ABdhPJxRDG2E/DjTkf1AcNcP3bclCVRmvuXKN+1wM94rWggFHvcNFccL1oXOusxAnZDqCcgK+VRHBqLE3gYhqV/HMcw=
X-Received: by 2002:a5d:640e:: with SMTP id z14mr25731662wru.258.1618428181450;
 Wed, 14 Apr 2021 12:23:01 -0700 (PDT)
MIME-Version: 1.0
From:   Erik Flodin <erik@flodin.me>
Date:   Wed, 14 Apr 2021 21:22:50 +0200
Message-ID: <CAAMKmofMUGrXPynSQXcvFCvB3nJXYrvosv63Aq4tcxyFok=rgA@mail.gmail.com>
Subject: CAN_RAW_RECV_OWN_MSGS and filters
To:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi all,

I've been using a raw CAN socket with RECV_OWN_MSGS enabled to get a
transmission confirmation when a frame has been sent. Today when I
tried to enable filters to limit what I receive to only those frames
that I'm interested in I noticed that the filters also affected
reception of my own frames. So in order to receive all frames that I
send I must also add a filter that matches all frames that I send.

Is this the expected behavior? I can see why it works the way it does,
but I had expected that setting the RECV_OWN_MSGS flag would give me
all frames sent on the socket. Is there a way to get my expected
behavior without having to set a filter that matches all frames that I
plan to send?

// Erik
