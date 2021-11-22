Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600AC458EC8
	for <lists+linux-can@lfdr.de>; Mon, 22 Nov 2021 13:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhKVM7z (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Nov 2021 07:59:55 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42372 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239507AbhKVM7z (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Nov 2021 07:59:55 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AMCuVHm107907;
        Mon, 22 Nov 2021 06:56:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637585791;
        bh=86PCuAHCF1E3Rn+MR0ZWMSwqRPl+D80wX/tnx0rh1cA=;
        h=From:To:CC:Subject:Date;
        b=h+12N1QM0Mdro5c0JGHp4oJ7YDV+664DkeHgePiv9nwVY+ntALl4gQW2v3+7foanZ
         JNCM3Sw+zJqB5zBMWxDKWasT/kFnaISIKGLOtB/DZeOjty4BgXCwgH+PxUHY2aQwqP
         /ONeYWJydnMg6y5/KRJAxbsLrVmFq7J5DWVy0/k0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AMCuV5w019714
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Nov 2021 06:56:31 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 22
 Nov 2021 06:56:30 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 22 Nov 2021 06:56:30 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AMCuQhx109786;
        Mon, 22 Nov 2021 06:56:27 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-can@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: [PATCH RFC v2 0/4] MUX: Add support for reading enable state from DT
Date:   Mon, 22 Nov 2021 18:26:20 +0530
Message-ID: <20211122125624.6431-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

- The following series of patches add support for reading the state of the
  mux to be set for enabling given device.
- As these are RFC patches I have combined them into a single series for
  better understanding of the reason behind making this change.

Changes since v1:
- Added support for reading the enable state from DT instead of hardcoding
  the state to be set to 1.
- Made relavent changes in the bindings

Link to v1,
- https://patchwork.kernel.org/project/linux-phy/list/?series=578863&state=*

Aswath Govindraju (4):
  dt-bindings: mux: Increase the number of arguments in mux-controls
  dt-bindings: phy: ti,tcan104x-can: Document mux-controls property
  mux: Add support for reading mux enable state from DT
  phy: phy-can-transceiver: Add support for setting mux

 .../devicetree/bindings/mux/gpio-mux.yaml     |  2 +-
 .../bindings/mux/mux-controller.yaml          |  2 +-
 .../bindings/phy/ti,tcan104x-can.yaml         |  8 ++++++
 drivers/mux/core.c                            | 20 ++++++++++++--
 drivers/phy/phy-can-transceiver.c             | 26 +++++++++++++++++++
 include/linux/mux/consumer.h                  |  1 +
 include/linux/mux/driver.h                    |  1 +
 7 files changed, 56 insertions(+), 4 deletions(-)

-- 
2.17.1

