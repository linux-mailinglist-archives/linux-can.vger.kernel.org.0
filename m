Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C743729A9
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 13:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhEDLuQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 07:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhEDLuQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 07:50:16 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69579C061574
        for <linux-can@vger.kernel.org>; Tue,  4 May 2021 04:49:21 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so1141717wmh.4
        for <linux-can@vger.kernel.org>; Tue, 04 May 2021 04:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q84SAFZ9YgUJPuhxt43Aae6Cv0kNsASjeaPd/A/vkl4=;
        b=FSlnLjXY5nE3ENIG/hWTNOoISQJGHl39+z6QBkhLU0yP+q6D1WU2WVc9Co3MB4KO8P
         cza4L4/Q3ldIaYxf0KkgliPNiEp22Fn5UehmiZ3LroD8LLtBF6R5n9ugY9i3s5AQSr6s
         OVNZM3B9P5ma6iD3KAXkTUfktdPXimWuNOv+0guyPcNz91zdJmlbwb95k9CuysUMGrBL
         7eLWDHHJEKuX52hQGKCmz/xdx2RHiC3Ma19IbJPLpAtk3+w6cz7+C4AJZlfKAl4onAu+
         HjXWkTK+6FVwEHIv97wZcvSgJNAifDAdXjFTChyAJcVnLSYOVRX0MDm56LRXZMWA/tXZ
         2fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q84SAFZ9YgUJPuhxt43Aae6Cv0kNsASjeaPd/A/vkl4=;
        b=Z8+/5TOsdDNlgIsyX9jxNTcYINFbz+TLzE6/O6XXyPk6aJl6+ASURlu/8CceJKlWqz
         FkfbQunb6tQzM78YPgy42bTKelTmwz1daMpVvIVAOvW+TLkKZEOtTsZC0M2MzYDEBcDO
         h6U8Fho03StahKL73U8OO7U2qsABsbYwazvyrfPnU7dZgb+KbiRNOdDMEKlg3dfVMD2Y
         OzCc4b5ZrmXuRaDN87vhjyXoneMLq/IxRqzA/dEYfliqG7fYpq5TEPeAA7/tkRMFGz1Q
         B93s1ezDv5UX1XG0SwyaCAsvYv3eAIqJ9tiU8posJ1dryMxtSKRL+uUyUc/+4pawseLG
         jDKA==
X-Gm-Message-State: AOAM530lUkoqAA6dng9LQIBdGEqggO85M/jzSPDuJweHa8e6x3C66c7L
        rZevhNooon64AriD2KablvbCGok4qtRtXWhJ
X-Google-Smtp-Source: ABdhPJw7dPsLH9iJxS5y50VpvLJc8pINA4rXmNiVfKnP3fVxQjHBbGX7RpOlMX6CGqjEWWixENIFvg==
X-Received: by 2002:a1c:3d05:: with SMTP id k5mr25974276wma.182.1620128959963;
        Tue, 04 May 2021 04:49:19 -0700 (PDT)
Received: from localhost.localdomain (92.41.10.173.threembb.co.uk. [92.41.10.173])
        by smtp.gmail.com with ESMTPSA id n10sm16181972wrw.37.2021.05.04.04.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 04:49:19 -0700 (PDT)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [REPOST PATCH 0/4] can: m_can: various regmask-related cleanup
Date:   Tue,  4 May 2021 12:48:56 +0100
Message-Id: <20210504114900.351170-1-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi all!

1/4 modernises m_can.c, using GENMASK for all regmasks and
FIELD_{GET,PREP,MAX} for ops. Maintainable, consistent and concise.

2/4 makes clear all the differences in CCCR between M_CAN spec
revisions,
and orders the defs by revision, ascending.

3/4 makes explicit the config of RX & TX buffer sizes, making it a bit
more readable, especially against the spec.

4/4 fixes whitespace in a few comments.

Cheers!

Torin
maxiluxsystems.com


---
Reposting to include signoffs in each commit.


