Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DD97AC7A8
	for <lists+linux-can@lfdr.de>; Sun, 24 Sep 2023 13:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjIXLJd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 24 Sep 2023 07:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIXLJd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 24 Sep 2023 07:09:33 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A87583
        for <linux-can@vger.kernel.org>; Sun, 24 Sep 2023 04:09:23 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3ae31be5ee9so1123423b6e.2
        for <linux-can@vger.kernel.org>; Sun, 24 Sep 2023 04:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695553763; x=1696158563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETSBtMvuBVLLqmoYkEPkeY5zikBVJYWY9uCm/VCNV88=;
        b=EWKx21yR2qC/U2xtZD8xDBMkJpAHTr4YbehMnGhnLYjE7BSHPLMFQbbB08SyT8fIVt
         uNdnTKeNm219kmmA+kpEtU+z9hqVxdzeexKLxtP2BjdEHmfJ1u54/JYDy5tcPmC03aH0
         GsSAJMwOhjy9LZ+mPSYdVcjaqUZ4/nDqEQH0UUZ8O+ZPzuHXP9RCwLiBv7jWJMAG1rix
         a+vOHsqtJpvbvTcSZxyoME2a0k9K1YZ7Z1IohcAKEpx4pZd3CIGxPXM7U0SSRIW8pgjI
         Cw8CNbtb9WN9HYTexf5mjKXAHSthlHBqU3kczUPTa9uW+cyb4BVi5wajqpKPLzk0MBrH
         pM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695553763; x=1696158563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ETSBtMvuBVLLqmoYkEPkeY5zikBVJYWY9uCm/VCNV88=;
        b=LhpJFh6ZyOGNs6gGN7evH9XC2JUk1jbNWdNCjYPoWsyDHeJ7dSIQquq423xVPwsvt7
         Impi79zB5GTvzCqR0RnM2kHOzPDdUGIQ0JG5J6GKk8Is408za68OSGg86C1juwFaqSKB
         6ceMI4mFt3S+vXulvLZJzfFxhSywi3xPpqdQXeDtLByZtTcsepmoGUtd7ElTfdmdODwD
         ivkOlRRYxEpmpXh9G45LxVpUObQSOQi5c7mbGJKyEnVOk4qtFYWSnRShtqWLEkLfRnjI
         OEtOqcd9JcqvFoEKUs7w10mzTe0ChXqHnqPrsLPni4CWyM5cJCkFibyY/XqYRjrVsuSz
         sFlQ==
X-Gm-Message-State: AOJu0YzcleawJSZuwfxDegNdCjTXBcxlNqDOz/MNw9d5z21wCaG9K/6Z
        sGWoS9QyUEyegp0CGfUVwkL0uFmsLz4=
X-Google-Smtp-Source: AGHT+IEkOO73miLo0vVo8HAqgSTrNyqcmip5sNF7ssEvgCKfSYXXi97P71MMy3U48NACbGud+kZxhg==
X-Received: by 2002:a05:6358:339b:b0:13a:a85b:a4ce with SMTP id i27-20020a056358339b00b0013aa85ba4cemr6044460rwd.16.1695553762613;
        Sun, 24 Sep 2023 04:09:22 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id a13-20020a63704d000000b00578f1a71a91sm6074905pgn.79.2023.09.24.04.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 04:09:22 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 1/2] can: etas_es58x: rework the version check logic to silence -Wformat-truncation
Date:   Sun, 24 Sep 2023 20:06:47 +0900
Message-ID: <20230924110914.183898-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230924110914.183898-1-mailhol.vincent@wanadoo.fr>
References: <20230914112954.3067242-1-mailhol.vincent@wanadoo.fr>
 <20230924110914.183898-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

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
index 9fba29e2f57c..4cc28771eb6f 100644
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
2.41.0

