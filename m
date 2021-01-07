Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1302ED5CD
	for <lists+linux-can@lfdr.de>; Thu,  7 Jan 2021 18:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbhAGRjs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 7 Jan 2021 12:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbhAGRjs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 7 Jan 2021 12:39:48 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93291C0612F5;
        Thu,  7 Jan 2021 09:39:07 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id h22so16566273lfu.2;
        Thu, 07 Jan 2021 09:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=sx6HsPLRcBhQznGjRrOL54Fb+xs1qGGIE/4P1MI0hiU=;
        b=dTXrZH4d+ZzIH5r/mhLurl4wN6YC+kgJIlaifo9pzElQ69dzGjcz724KxyPLMMayd3
         aTc6xqqOAW9tOvzJk6SpX7Zo4e4C3KGNYOZ1QGFoBr5paVYc3gRAu+Zwz3tQlUJm9hXP
         Ubk2aABKZLRRlK78V3ai6CcJpG5Nwy0L+zlIJ9cXc/RrqNdmsFg8oYJ7sa6H0lwtTJhi
         kWB+SzOuwUyTnfqG6Zbf/bTF0oIr8VGd+SLlYC48aZRKZkCxdOyk6i8kTCMyDUlC7JgJ
         jNSa/2TLRY0TQmBE63C4xWbQDUKGrPUryvEL5M+kNk0CuxQ9BMnCeTWj4+rHNeyWDSAJ
         /xMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=sx6HsPLRcBhQznGjRrOL54Fb+xs1qGGIE/4P1MI0hiU=;
        b=kF8S6xTtLQkH61I+rSQGgflkveh7tUSrB6u5ztEoRVx2H1zcXb0kmjdpRD8XZsDvlq
         F0kGWpGltpXmAop1FcJOsUUWKjl1QqynnuFRyih73MHZQaDp4gRjwXAmEaWUemmSjPDT
         KEOILOBc+fj2H+h68X3LvMn036aAX8IHJb/KDHE4Y9IuiDQqTKJCrIraKHvfHEOY+/uK
         O/tpIziaPFF0sDi8sL30TPm3HE8z9as8OESCecf6Uqf+iN0n/foJLgQ8OQzU1lVNSEpX
         UQX0Hvh3hPqZWoxgXiQ2HgcxLjH6OAIfejZ85BimIteawOEntPWX7c5qJpc4LGFh1WO2
         N2Jw==
X-Gm-Message-State: AOAM532GrdY1mzuqb7id7ScRlMXa1vGbYNx6gEENpbkUHSpG33/rNou3
        40q61V0V1EKAhiVMBkegwoL9iqCsXBs62Yy1RRpmDkJUD7gj/Q==
X-Google-Smtp-Source: ABdhPJxAEB8NWho/gzHdkuZvKGUtWcwXBhFxcwStgKf/DuPX6OJtqBzvdEkbAAOqdiiJ0UMaakutWDgLU7QCFip02so=
X-Received: by 2002:a05:6512:1102:: with SMTP id l2mr4173676lfg.500.1610041146000;
 Thu, 07 Jan 2021 09:39:06 -0800 (PST)
MIME-Version: 1.0
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 7 Jan 2021 14:38:54 -0300
Message-ID: <CAOMZO5AZYVcsMq=oE-Q_aDCEGrJEH9K5p1uqFzoUeiy3tg1SMQ@mail.gmail.com>
Subject: Describing the STB pin of the CAN transceiver
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

The imx6ul-evk uses a MC34901 CAN transceiver and the STB pin
(standby_ needs to be controlled (1 = standby, 0 = normal mode)

As far as I can see, there is no support for the STB pin currently in
he can framework.

What would be the correct way to describe it in the devicetree?

Would it be acceptable to use something like this?
https://pastebin.com/raw/SsY6USdT

Or any other idea?

I can give a try to add this support after we reach a conclusion for
the approach.

Thanks,

Fabio Estevam
