Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0927BAAE3
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 21:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjJET63 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 15:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjJET6V (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 15:58:21 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36B8EE
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 12:58:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoUUC-0004e2-61
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 21:58:16 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoUUB-00BLDW-O9
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 21:58:15 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 71A8A22FF82
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 19:58:15 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 33A2622FF62;
        Thu,  5 Oct 2023 19:58:14 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 1d65ec65;
        Thu, 5 Oct 2023 19:58:13 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 02/37] can: etas_es58x: rework the version check logic to silence -Wformat-truncation
Date:   Thu,  5 Oct 2023 21:57:37 +0200
Message-Id: <20231005195812.549776-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231005195812.549776-1-mkl@pengutronix.de>
References: <20231005195812.549776-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Following [1], es58x_devlink.c now triggers the following
format-truncation GCC warnings:

  drivers/net/can/usb/etas_es58x/es58x_devlink.c: In function ‘es58x_devlink_info_get’:
  drivers/net/can/usb/etas_es58x/es58x_devlink.c:201:41: warning: ‘%02u’ directive output may be truncated writing between 2 and 3 bytes into a region of size between 1 and 3 [-Wformat-truncation=]
    201 |   snprintf(buf, sizeof(buf), "%02u.%02u.%02u",
        |                                         ^~~~
  drivers/net/can/usb/etas_es58x/es58x_devlink.c:201:30: note: directive argument in the range [0, 255]
    201 |   snprintf(buf, sizeof(buf), "%02u.%02u.%02u",
        |                              ^~~~~~~~~~~~~~~~
  drivers/net/can/usb/etas_es58x/es58x_devlink.c:201:3: note: ‘snprintf’ output between 9 and 12 bytes into a destination of size 9
    201 |   snprintf(buf, sizeof(buf), "%02u.%02u.%02u",
        |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    202 |     fw_ver->major, fw_ver->minor, fw_ver->revision);
        |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/usb/etas_es58x/es58x_devlink.c:211:41: warning: ‘%02u’ directive output may be truncated writing between 2 and 3 bytes into a region of size between 1 and 3 [-Wformat-truncation=]
    211 |   snprintf(buf, sizeof(buf), "%02u.%02u.%02u",
        |                                         ^~~~
  drivers/net/can/usb/etas_es58x/es58x_devlink.c:211:30: note: directive argument in the range [0, 255]
    211 |   snprintf(buf, sizeof(buf), "%02u.%02u.%02u",
        |                              ^~~~~~~~~~~~~~~~
  drivers/net/can/usb/etas_es58x/es58x_devlink.c:211:3: note: ‘snprintf’ output between 9 and 12 bytes into a destination of size 9
    211 |   snprintf(buf, sizeof(buf), "%02u.%02u.%02u",
        |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    212 |     bl_ver->major, bl_ver->minor, bl_ver->revision);
        |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/usb/etas_es58x/es58x_devlink.c:221:38: warning: ‘%03u’ directive output may be truncated writing between 3 and 5 bytes into a region of size between 2 and 4 [-Wformat-truncation=]
    221 |   snprintf(buf, sizeof(buf), "%c%03u/%03u",
        |                                      ^~~~
  drivers/net/can/usb/etas_es58x/es58x_devlink.c:221:30: note: directive argument in the range [0, 65535]
    221 |   snprintf(buf, sizeof(buf), "%c%03u/%03u",
        |                              ^~~~~~~~~~~~~
  drivers/net/can/usb/etas_es58x/es58x_devlink.c:221:3: note: ‘snprintf’ output between 9 and 13 bytes into a destination of size 9
    221 |   snprintf(buf, sizeof(buf), "%c%03u/%03u",
        |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    222 |     hw_rev->letter, hw_rev->major, hw_rev->minor);
        |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is not an actual bug because the sscanf() parsing makes sure that
the u8 are only two digits long and the u16 only three digits long.
Thus below declaration:

	char buf[max(sizeof("xx.xx.xx"), sizeof("axxx/xxx"))];

allocates just what is needed to represent either of the versions.

This warning was known but ignored because, at the time of writing,
-Wformat-truncation was not present in the kernel, not even at W=3 [2].

One way to silence this warning is to check the range of all sub
version numbers are valid: [0, 99] for u8 and range [0, 999] for u16.

The module already has a logic which considers that when all the sub
version numbers are zero, the version number is not set. Note that not
having access to the device specification, this was an arbitrary
decision. This logic can thus be removed in favor of global check that
would cover both cases:

  - the version number is not set (parsing failed)
  - the version number is not valid (paranoiac check to please gcc)

Before starting to parse the product info string, set the version
sub-numbers to the maximum unsigned integer thus violating the
definitions of struct es58x_sw_version or struct es58x_hw_revision.

Then, rework the es58x_sw_version_is_set() and
es58x_hw_revision_is_set() functions: remove the check that the
sub-numbers are non zero and replace it by a check that they fit in
the expected number of digits. This done, rename the functions to
reflect the change and rewrite the documentation. While doing so, also
add a description of the return value.

Finally, the previous version only checked that
&es58x_hw_revision.letter was not the null character. Replace this
check by an alphanumeric character check to make sure that we never
return a special character or a non-printable one and update the
documentation of struct es58x_hw_revision accordingly.

All those extra checks are paranoid but have the merit to silence the
newly introduced W=1 format-truncation warning [1].

[1] commit 6d4ab2e97dcf ("extrawarn: enable format and stringop overflow warnings in W=1")
Link: https://git.kernel.org/torvalds/c/6d4ab2e97dcf

[2] https://lore.kernel.org/all/CAMZ6Rq+K+6gbaZ35SOJcR9qQaTJ7KR0jW=XoDKFkobjhj8CHhw@mail.gmail.com/

Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
Closes: https://lore.kernel.org/linux-can/20230914-carrousel-wrecker-720a08e173e9-mkl@pengutronix.de/
Fixes: 9f06631c3f1f ("can: etas_es58x: export product information through devlink_ops::info_get()")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20230924110914.183898-2-mailhol.vincent@wanadoo.fr
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/etas_es58x/es58x_core.h   |  6 +-
 .../net/can/usb/etas_es58x/es58x_devlink.c    | 57 +++++++++++++------
 2 files changed, 42 insertions(+), 21 deletions(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.h b/drivers/net/can/usb/etas_es58x/es58x_core.h
index c1ba1a4e8857..2e183bdeedd7 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.h
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.h
@@ -378,13 +378,13 @@ struct es58x_sw_version {
 
 /**
  * struct es58x_hw_revision - Hardware revision number.
- * @letter: Revision letter.
+ * @letter: Revision letter, an alphanumeric character.
  * @major: Version major number, represented on three digits.
  * @minor: Version minor number, represented on three digits.
  *
  * The hardware revision uses its own format: "axxx/xxx" where 'a' is
- * a letter and 'x' a digit. It can be retrieved from the product
- * information string.
+ * an alphanumeric character and 'x' a digit. It can be retrieved from
+ * the product information string.
  */
 struct es58x_hw_revision {
 	char letter;
diff --git a/drivers/net/can/usb/etas_es58x/es58x_devlink.c b/drivers/net/can/usb/etas_es58x/es58x_devlink.c
index 9fba29e2f57c..635edeb8f68c 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_devlink.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_devlink.c
@@ -125,14 +125,28 @@ static int es58x_parse_hw_rev(struct es58x_device *es58x_dev,
  * firmware version, the bootloader version and the hardware
  * revision.
  *
- * If the function fails, simply emit a log message and continue
- * because product information is not critical for the driver to
- * operate.
+ * If the function fails, set the version or revision to an invalid
+ * value and emit an informal message. Continue probing because the
+ * product information is not critical for the driver to operate.
  */
 void es58x_parse_product_info(struct es58x_device *es58x_dev)
 {
+	static const struct es58x_sw_version sw_version_not_set = {
+		.major = -1,
+		.minor = -1,
+		.revision = -1,
+	};
+	static const struct es58x_hw_revision hw_revision_not_set = {
+		.letter = '\0',
+		.major = -1,
+		.minor = -1,
+	};
 	char *prod_info;
 
+	es58x_dev->firmware_version = sw_version_not_set;
+	es58x_dev->bootloader_version = sw_version_not_set;
+	es58x_dev->hardware_revision = hw_revision_not_set;
+
 	prod_info = usb_cache_string(es58x_dev->udev, ES58X_PROD_INFO_IDX);
 	if (!prod_info) {
 		dev_warn(es58x_dev->dev,
@@ -150,29 +164,36 @@ void es58x_parse_product_info(struct es58x_device *es58x_dev)
 }
 
 /**
- * es58x_sw_version_is_set() - Check if the version is a valid number.
+ * es58x_sw_version_is_valid() - Check if the version is a valid number.
  * @sw_ver: Version number of either the firmware or the bootloader.
  *
- * If &es58x_sw_version.major, &es58x_sw_version.minor and
- * &es58x_sw_version.revision are all zero, the product string could
- * not be parsed and the version number is invalid.
+ * If any of the software version sub-numbers do not fit on two
+ * digits, the version is invalid, most probably because the product
+ * string could not be parsed.
+ *
+ * Return: @true if the software version is valid, @false otherwise.
  */
-static inline bool es58x_sw_version_is_set(struct es58x_sw_version *sw_ver)
+static inline bool es58x_sw_version_is_valid(struct es58x_sw_version *sw_ver)
 {
-	return sw_ver->major || sw_ver->minor || sw_ver->revision;
+	return sw_ver->major < 100 && sw_ver->minor < 100 &&
+		sw_ver->revision < 100;
 }
 
 /**
- * es58x_hw_revision_is_set() - Check if the revision is a valid number.
+ * es58x_hw_revision_is_valid() - Check if the revision is a valid number.
  * @hw_rev: Revision number of the hardware.
  *
- * If &es58x_hw_revision.letter is the null character, the product
- * string could not be parsed and the hardware revision number is
- * invalid.
+ * If &es58x_hw_revision.letter is not a alphanumeric character or if
+ * any of the hardware revision sub-numbers do not fit on three
+ * digits, the revision is invalid, most probably because the product
+ * string could not be parsed.
+ *
+ * Return: @true if the hardware revision is valid, @false otherwise.
  */
-static inline bool es58x_hw_revision_is_set(struct es58x_hw_revision *hw_rev)
+static inline bool es58x_hw_revision_is_valid(struct es58x_hw_revision *hw_rev)
 {
-	return hw_rev->letter != '\0';
+	return isalnum(hw_rev->letter) && hw_rev->major < 1000 &&
+		hw_rev->minor < 1000;
 }
 
 /**
@@ -197,7 +218,7 @@ static int es58x_devlink_info_get(struct devlink *devlink,
 	char buf[max(sizeof("xx.xx.xx"), sizeof("axxx/xxx"))];
 	int ret = 0;
 
-	if (es58x_sw_version_is_set(fw_ver)) {
+	if (es58x_sw_version_is_valid(fw_ver)) {
 		snprintf(buf, sizeof(buf), "%02u.%02u.%02u",
 			 fw_ver->major, fw_ver->minor, fw_ver->revision);
 		ret = devlink_info_version_running_put(req,
@@ -207,7 +228,7 @@ static int es58x_devlink_info_get(struct devlink *devlink,
 			return ret;
 	}
 
-	if (es58x_sw_version_is_set(bl_ver)) {
+	if (es58x_sw_version_is_valid(bl_ver)) {
 		snprintf(buf, sizeof(buf), "%02u.%02u.%02u",
 			 bl_ver->major, bl_ver->minor, bl_ver->revision);
 		ret = devlink_info_version_running_put(req,
@@ -217,7 +238,7 @@ static int es58x_devlink_info_get(struct devlink *devlink,
 			return ret;
 	}
 
-	if (es58x_hw_revision_is_set(hw_rev)) {
+	if (es58x_hw_revision_is_valid(hw_rev)) {
 		snprintf(buf, sizeof(buf), "%c%03u/%03u",
 			 hw_rev->letter, hw_rev->major, hw_rev->minor);
 		ret = devlink_info_version_fixed_put(req,
-- 
2.40.1


