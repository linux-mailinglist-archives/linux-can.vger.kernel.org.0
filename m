Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E783BED54
	for <lists+linux-can@lfdr.de>; Wed,  7 Jul 2021 19:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhGGRsB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 7 Jul 2021 13:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhGGRsA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Jul 2021 13:48:00 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0D2C061574
        for <linux-can@vger.kernel.org>; Wed,  7 Jul 2021 10:45:18 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id g12so2670496qtb.2
        for <linux-can@vger.kernel.org>; Wed, 07 Jul 2021 10:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=FfR3EXgZI/NWhZ7z8AfrnfE0BsMefBJqItpzconP07Y=;
        b=jjs2mvX5UWnO67N6XYvPHLdAo5j+8o0U49JBc4JkgaoJTZ6zZo60As00Bespf5Sveq
         aQGbzAR5ShWe6fgcnh9TtkwpGGnHzwIYh1eUmhjDylfErKLQZN8K7xrG0NbVu4LeQ6ny
         QWx+pd0lpoLZvWH5X1Gpk32OdcEjn9480p9EiOovTeBtun76wos/eERjiinFvhLEnAk3
         ICKUk+XJ8rpDFE6jpHt4ie8c8itgz2ynC/fg1+3gG+Fp7JnBlkmCKQjx6GQiR6F7fyLp
         bAsVUt1drulRZmCCapYxgZN9LpvJzSM5V2TJa552xyTYs1qUb6nsnV2UUgunhnG0CCYi
         flTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=FfR3EXgZI/NWhZ7z8AfrnfE0BsMefBJqItpzconP07Y=;
        b=ljwm3uOS64N5toioRmb4UAstpMIj6klPAdfgORkRaKleoNkimlYk1uusGpMXo39VWH
         4Uz3/ECkgBrNQnP8y6Z5M/kUpk4NwXAdIVghJoW6xpYA97jbv7c0VKO5R8HGLrQ7gsir
         gym4ovsw1pBoiB3XEFhghKvMv9cwS7FU4aT83e9oULjpStLCS0IuGyu0JFL7FIyLSErN
         60GfvaNKWRzMRFwXK0smENvXlq1Mn8yyoGKUOnji2ze2tCYk8i/kTeA13wQ7vXLM+stq
         cUwdtsnoUNE/1HgAMq8s3DptXC69y1RdZ43/Rz2UORNJU6Fy/EETwmDn0w6qhdXpTPHJ
         z9iA==
X-Gm-Message-State: AOAM532N3gpF7mVQ4BKI7kN3CIYgi2ZQKeocw/xJvbVhrWUexZvoTK2c
        U0G2z2VZ3KlgPJt23i8Lyco=
X-Google-Smtp-Source: ABdhPJxdO7cINnIT2n8UOIgY6LNrrqkfVXfZXbPSsTvZFSrHnzKSkIaY24sfDuvb5boPj6+/kZDawg==
X-Received: by 2002:ac8:775c:: with SMTP id g28mr10662207qtu.193.1625679918046;
        Wed, 07 Jul 2021 10:45:18 -0700 (PDT)
Received: from DTJQUESENBERRY ([2001:468:c80:a202:13e:6f62:b761:81c5])
        by smtp.gmail.com with ESMTPSA id h7sm6865314qtq.79.2021.07.07.10.45.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jul 2021 10:45:17 -0700 (PDT)
From:   "Joshua Quesenberry" <engnfrc@gmail.com>
To:     <linux-can@vger.kernel.org>
Cc:     <engnfrc@gmail.com>
Subject: ip link valid options checking
Date:   Wed, 7 Jul 2021 13:45:16 -0400
Message-ID: <002501d77357$d93c36b0$8bb4a410$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AddzV6mHoqDJXZTYR7O82+vlM/59OA==
Content-Language: en-us
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Good Afternoon,

Do any of you know a way to check what options are valid when setting up a
CAN device with the ip link commands, either from bash or through C++? I'm
working on a piece of code that will get used on systems with varying CAN
drivers and for instance one of them doesn't support CAN-FD, so how would I
be able to know that setting the fd flag or dbitrate value would fail before
calling the setup command and seeing it fail?

Thanks,

Josh Q


