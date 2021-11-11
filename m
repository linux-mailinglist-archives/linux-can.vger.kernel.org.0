Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03C144DAA4
	for <lists+linux-can@lfdr.de>; Thu, 11 Nov 2021 17:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbhKKQqX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 11 Nov 2021 11:46:23 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33888 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbhKKQqW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 11 Nov 2021 11:46:22 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1ABGhJC3098226;
        Thu, 11 Nov 2021 10:43:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1636648999;
        bh=XFjprkplom3curDEOP2tC8estXvrW8fX+kjqvTjHgco=;
        h=From:To:CC:Subject:Date;
        b=REYPZVAQ75yJya9yDSSs92alU3mJNiBJZV0sY3LTn+d//WK2aMfz2FhUrD5gVgE1O
         e1Ej9prGHI+y+ezpDqFGSxORuDCmN3vQBER5c6qXG8KNh2xNB5oZLnugffTeSkZCOe
         a/Sry+akLbHPqtQqQN6EHyywTt8+wVIv+MPoCCLA=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1ABGhJva091105
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Nov 2021 10:43:19 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 11
 Nov 2021 10:43:18 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 11 Nov 2021 10:43:18 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1ABGhEg2104171;
        Thu, 11 Nov 2021 10:43:15 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-can@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC 0/2] CAN TRANSCEIVER: Add support for setting mux
Date:   Thu, 11 Nov 2021 22:13:10 +0530
Message-ID: <20211111164313.649-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On some boards, for routing CAN signals from controller to transceiver,
muxes might need to be set. Therefore, add support for setting the mux by
reading the mux-controls property from the device tree node.

Aswath Govindraju (2):
  dt-bindings: phy: ti,tcan104x-can: Document mux-controls property
  phy: phy-can-transceiver: Add support for setting mux

 .../bindings/phy/ti,tcan104x-can.yaml         |  6 ++++++
 drivers/phy/phy-can-transceiver.c             | 21 +++++++++++++++++++
 2 files changed, 27 insertions(+)

-- 
2.17.1

