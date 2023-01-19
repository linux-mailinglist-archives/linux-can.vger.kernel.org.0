Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40521673E20
	for <lists+linux-can@lfdr.de>; Thu, 19 Jan 2023 17:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjASQBc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Jan 2023 11:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjASQBa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Jan 2023 11:01:30 -0500
Received: from mail3.ems-wuensche.com (mail3.ems-wuensche.com [81.169.186.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C24D8457E
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 08:01:24 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id E2256FFA59
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 15:46:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Score: -1.902
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 82OP_drEQaop for <linux-can@vger.kernel.org>;
        Thu, 19 Jan 2023 16:46:19 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     mkl@pengutronix.de, linux-can@vger.kernel.org
Cc:     wg@grandegger.com,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH 0/8] can: ems_pci: Add support for CPC-PCIe v3
Date:   Thu, 19 Jan 2023 16:45:20 +0100
Message-Id: <20230119154528.28425-1-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The CPC-PCIe v3 uses a Asix AX99100 instead of the discontinued 
PLX PCI9030 bridge chip. This patch series adds support for this 
card version and cleaned some code styling issues.

Gerhard Uttenthaler (8):
  Fixed code style, copyright and email address
  Added Asix AX99100 definitions
  Initialize BAR registers
  Added read/write register and post irq functions
  Initialize CAN controller base addresses
  Added IRQ enable
  Deassert hardware reset
  Added MODULE_AUTHOR

 drivers/net/can/sja1000/ems_pci.c | 152 ++++++++++++++++++++++--------
 1 file changed, 113 insertions(+), 39 deletions(-)

-- 
2.35.3

--
EMS Dr. Thomas Wuensche e.K.
Sonnenhang 3
85304 Ilmmuenster
HR Ingolstadt, HRA 170106

Phone: +49-8441-490260
Fax  : +49-8441-81860
http://www.ems-wuensche.com
