Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC2B2B0C3E
	for <lists+linux-can@lfdr.de>; Thu, 12 Nov 2020 19:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgKLSFG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 12 Nov 2020 13:05:06 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:54726 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgKLSFG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 12 Nov 2020 13:05:06 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 9D445FFAA1
        for <linux-can@vger.kernel.org>; Thu, 12 Nov 2020 18:05:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 tagged_above=-9999.9 required=5
        tests=[BAYES_00=-1.9, NO_RECEIVED=-0.001, NO_RELAYS=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id D4SIpuyXBX7p for <linux-can@vger.kernel.org>;
        Thu, 12 Nov 2020 19:05:03 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH v2 14/16] can: ems_usb: Made structs packed
Date:   Thu, 12 Nov 2020 19:03:44 +0100
Message-Id: <20201112180346.29070-15-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201112180346.29070-1-uttenthaler@ems-wuensche.com>
References: <20201112180346.29070-1-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Both devices expect everything from the host as packed

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/usb/ems_usb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 693ef333ceab..677ed4bc47b9 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -132,7 +132,7 @@ MODULE_LICENSE("GPL v2");
  * CPC_MSG_TYPE_CAN_FRAME or CPC_MSG_TYPE_RTR_FRAME or
  * CPC_MSG_TYPE_EXT_CAN_FRAME or CPC_MSG_TYPE_EXT_RTR_FRAME.
  */
-struct cpc_can_msg {
+struct __packed cpc_can_msg {
 	__le32 id;
 	u8 length;
 	u8 msg[8];
@@ -160,7 +160,7 @@ struct __packed cpc_canfd_msg {
 #define CPC_FDFLAG_XTD          BIT(7)
 
 /* Representation of the CAN parameters for the SJA1000 controller */
-struct cpc_sja1000_params {
+struct __packed cpc_sja1000_params {
 	u8 mode;
 	u8 acc_code0;
 	u8 acc_code1;
@@ -218,20 +218,20 @@ struct cpc_confirm {
 };
 
 /* Structure for overrun conditions */
-struct cpc_overrun {
+struct __packed cpc_overrun {
 	u8 event;
 	u8 count;
 };
 
 /* SJA1000 CAN errors (compatible to NXP LPC2119) */
-struct cpc_sja1000_can_error {
+struct __packed cpc_sja1000_can_error {
 	u8 ecc;
 	u8 rxerr;
 	u8 txerr;
 };
 
 /* structure for CAN error conditions */
-struct cpc_can_error {
+struct __packed cpc_can_error {
 	u8 ecode;
 
 	struct {
@@ -247,7 +247,7 @@ struct cpc_can_error {
 /* Structure containing RX/TX error counter. This structure is used to request
  * the values of the CAN controllers TX and RX error counter.
  */
-struct cpc_can_err_counter {
+struct __packed cpc_can_err_counter {
 	u8 rx;
 	u8 tx;
 };
-- 
2.26.2

-- 
EMS Dr. Thomas Wuensche e.K.
Sonnenhang 3
85304 Ilmmuenster
HR Ingolstadt, HRA 170106

Phone: +49-8441-490260
Fax  : +49-8441-81860
http://www.ems-wuensche.com
