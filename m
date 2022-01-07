Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486DA4873F2
	for <lists+linux-can@lfdr.de>; Fri,  7 Jan 2022 09:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345507AbiAGINS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 7 Jan 2022 03:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345499AbiAGINR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 7 Jan 2022 03:13:17 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242F0C06118A
        for <linux-can@vger.kernel.org>; Fri,  7 Jan 2022 00:13:16 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id k18so9507657wrg.11
        for <linux-can@vger.kernel.org>; Fri, 07 Jan 2022 00:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y5vv85VvwS9MS7JlafP+Njn1B1aPbUU7IaGWNQUgbis=;
        b=iL8oFfe43QgftfpgHnQgjVBubyyuLqUpSLqUuyf72+AdnVY5pkBhR2O1qtoN8yBp2K
         3A2ayZWo16ycvCobtZkcAr10oKUS3kiB3Syngs28BfMwZyba3NTBiaKqnrPZzd4sqmIV
         AMuNWq3z2ioyIpUNGZOSvSTEV8BKw82l+Ucr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y5vv85VvwS9MS7JlafP+Njn1B1aPbUU7IaGWNQUgbis=;
        b=QgZcmAKLZfl75FixjOw/+u6H3I9wa8dHoF2iF1Sow+VIXtmmOPRzL66DEQ2IiP1tup
         K4cYNlODfU4IZAZlm4Xo3eRxYkcxzYTfNGtg8RN7eTlzrrUltRNlpSCxTc7fQoXFxh/x
         aoXMj+vxQPHYxloNA4uvr6X0a5ILP72XQimeLiVflBwBJSMRy2+5oQgJcJhnDIAPkPYA
         2lpVMluda+8w8nDpF4T6NpEnEd5e1u9Te7lUSX2AZkP+sDfJM2n0yCrf3eC4ViLwF0pv
         o+o+GfvAuN7MDfyt0Z3C06bQpjssNyXNIybaZlS/pSCRo6TcBaY56+z+MB2ab2IxKKRd
         zZAA==
X-Gm-Message-State: AOAM533xTN4Ej0hWPnHKwMOwn5SSReoPuQ71Gc6f4qDvdzDZdpExNyP+
        SFmThF1gbMmGgSRgzM3FChlB3g==
X-Google-Smtp-Source: ABdhPJyPwaMZa0yQeRjywazx6ncmfSazFg4h+xLedFtfm2vQlCvyJNrBejHstFH3Rpo0cAI3CmiyTA==
X-Received: by 2002:a5d:4525:: with SMTP id j5mr9452235wra.519.1641543194804;
        Fri, 07 Jan 2022 00:13:14 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (mob-5-90-38-18.net.vodafone.it. [5.90.38.18])
        by smtp.gmail.com with ESMTPSA id w17sm4280633wmc.14.2022.01.07.00.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 00:13:14 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Coiby Xu <coiby.xu@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        M Chetan Kumar <m.chetan.kumar@intel.com>,
        linux-doc@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC PATCH 1/2] docs: networking: device drivers: add can sub-folder
Date:   Fri,  7 Jan 2022 09:13:05 +0100
Message-Id: <20220107081306.3681899-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220107081306.3681899-1-dario.binacchi@amarulasolutions.com>
References: <20220107081306.3681899-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add the container for CAN drivers documentation.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 .../networking/device_drivers/can/index.rst    | 18 ++++++++++++++++++
 .../networking/device_drivers/index.rst        |  1 +
 2 files changed, 19 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/can/index.rst

diff --git a/Documentation/networking/device_drivers/can/index.rst b/Documentation/networking/device_drivers/can/index.rst
new file mode 100644
index 000000000000..218276818968
--- /dev/null
+++ b/Documentation/networking/device_drivers/can/index.rst
@@ -0,0 +1,18 @@
+.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+Controller Area Network (CAN) Device Drivers
+============================================
+
+Device drivers for CAN devices.
+
+Contents:
+
+.. toctree::
+   :maxdepth: 2
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/networking/device_drivers/index.rst b/Documentation/networking/device_drivers/index.rst
index 3a5a1d46e77e..5f5cfdb2a300 100644
--- a/Documentation/networking/device_drivers/index.rst
+++ b/Documentation/networking/device_drivers/index.rst
@@ -11,6 +11,7 @@ Contents:
    appletalk/index
    atm/index
    cable/index
+   can/index
    cellular/index
    ethernet/index
    fddi/index
-- 
2.32.0

