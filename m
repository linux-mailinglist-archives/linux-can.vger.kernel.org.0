Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87821459D83
	for <lists+linux-can@lfdr.de>; Tue, 23 Nov 2021 09:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhKWIQN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Nov 2021 03:16:13 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40298 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhKWIQK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Nov 2021 03:16:10 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AN8CofF036460;
        Tue, 23 Nov 2021 02:12:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637655170;
        bh=PhU8+RbRCaEcbY4Y/99QKnNNouSYkie7CFmexJUpGSI=;
        h=From:To:CC:Subject:Date;
        b=ME3pO5yhlh10eYrARjfuVH+AHuSTNWWfkkU1Xo0aixzkNIfFbQ4hFrpx6HUyF3O5p
         eKb3nkoy8Es49Wy7eNVchCZOywXqsWxebM/cBd0DyXKpj4Is5SDvbOMKm4A7UqtdUD
         SoDF04/1u5y1QGZAGWLJS1hDxWmqnlTKF8BZonJQ=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AN8CopR010617
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Nov 2021 02:12:50 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 23
 Nov 2021 02:12:28 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 23 Nov 2021 02:12:28 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AN8CNdw101399;
        Tue, 23 Nov 2021 02:12:24 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-can@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: [PATCH RFC v3 0/4] MUX: Add support for reading enable state from DT
Date:   Tue, 23 Nov 2021 13:42:17 +0530
Message-ID: <20211123081222.27979-1-a-govindraju@ti.com>
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

Changes since v2:
- Fixed changes in phy-can-transceiver based on comments
- added select MULTIPLEXER in drivers/phy/Kconfig
- Changed the implemetation of getting state by adding new apis

Changes since v1:
- Added support for reading the enable state from DT instead of hardcoding
  the state to be set to 1.
- Made relavent changes in the bindings

Link to v2:
- https://patchwork.kernel.org/project/linux-phy/list/?series=583917

Link to v1,
- https://patchwork.kernel.org/project/linux-phy/list/?series=578863&state=*

Aswath Govindraju (4):
  dt-bindings: mux: Increase the number of arguments in mux-controls
  dt-bindings: phy: ti,tcan104x-can: Document mux-controls property
  mux: Add support for reading mux enable state from DT
  phy: phy-can-transceiver: Add support for setting mux

 .../devicetree/bindings/mux/gpio-mux.yaml     |   2 +-
 .../bindings/mux/mux-controller.yaml          |   2 +-
 .../bindings/phy/ti,tcan104x-can.yaml         |   8 +
 drivers/mux/core.c                            | 146 +++++++++++++++++-
 drivers/phy/Kconfig                           |   1 +
 drivers/phy/phy-can-transceiver.c             |  22 +++
 include/linux/mux/consumer.h                  |  19 ++-
 include/linux/mux/driver.h                    |  13 ++
 8 files changed, 206 insertions(+), 7 deletions(-)

-- 
2.17.1

