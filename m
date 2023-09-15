Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F35F7A15B6
	for <lists+linux-can@lfdr.de>; Fri, 15 Sep 2023 07:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjIOFsj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 15 Sep 2023 01:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjIOFsj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 15 Sep 2023 01:48:39 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003AC2737
        for <linux-can@vger.kernel.org>; Thu, 14 Sep 2023 22:48:22 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68fc9a4ebe9so1591362b3a.2
        for <linux-can@vger.kernel.org>; Thu, 14 Sep 2023 22:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694756902; x=1695361702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guyJGYqM+6nb5JVMVDw/96iP+t3LclcMA/6C9EeTr28=;
        b=KPaYTV2JX/1+Os7b6hqivlMfcrRds6/fSRNz1mMYUai4Deij2Hr6ZjkEAP10muWcjh
         4JcmyNFzEUL6yOwG4R9m4tkmEWJAoUn0higO0p3O6g2tSEw+VImQudYkIYq7V8HUawzs
         GW3aC87BnfKFRtjDOscqZ23hz2htR3aoPeiJfYV6jaRNAQw/m00QTnS6LdpbwICTtd3G
         zouHG/89ijaSF2yJinVGCiBJQnYKVmRXOo6tuC30pKS2EgWJcXvdNLXCYJ0sn/d0YPrr
         Op89XyNzhx9fhHR0LIYn97g7d1zzXUsbHNHOxPbdijLNdtaD69KjRcjbrAiI/+BNm1Y1
         W5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694756902; x=1695361702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=guyJGYqM+6nb5JVMVDw/96iP+t3LclcMA/6C9EeTr28=;
        b=qOnQQc+BP+FHZh6gHw0ZGYHE0F3H4g3FoI3ISxlCkm16rkdPbTyy49WlPhYfaWc0Wd
         DQ+ytjYJ3K8fZf19S7zZolJ4avumlT6Q0vyBLlhIfI4cJnqgqd7ix2yP41PJiO6UDWY/
         iTitQUDItqk0yZQU7wiB58udSpv+R0ba/LQd0tdTDFr18xcCaOwwc2X926GFtnh+7i/J
         z4ZUv6cr1w0qLwwaM6yxaqq4v9476/7/VtUVSlo8e3AMwDCfYefO7+3uZA3bdJnwTmix
         ErYeo+t0MRUafk5Kg9GuOaDC4lmM2IdBOOSeS5EnJG6dWqw5yjybD6+JM+mFBSiea95Q
         rBZQ==
X-Gm-Message-State: AOJu0YwDAVHVK0RbPEHBMemnotavM8EXzoCA3n9Wkr/61X/dN5tYzEXX
        C1fP6XqV2/2lzgkR/X5virf9v99L5N4=
X-Google-Smtp-Source: AGHT+IHmRjtIzgTdsCjQf4O+9THOO2UGJmqRTy5bDQo60h5R4Yq6pSpGj1PDY+qvJD1+LxVjJGW44A==
X-Received: by 2002:a05:6a20:e10a:b0:132:ff57:7fab with SMTP id kr10-20020a056a20e10a00b00132ff577fabmr1301766pzb.2.1694756902338;
        Thu, 14 Sep 2023 22:48:22 -0700 (PDT)
Received: from XH22050090-L.ad.ts.tri-ad.global ([103.175.111.222])
        by smtp.gmail.com with ESMTPSA id s3-20020aa78d43000000b0068c62a45be6sm2268742pfe.179.2023.09.14.22.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 22:48:21 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 1/2] can: etas_es58x: rework the version check logic to silence -Wformat-truncation
Date:   Fri, 15 Sep 2023 14:48:14 +0900
Message-Id: <20230915054815.3130251-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915054815.3130251-1-mailhol.vincent@wanadoo.fr>
References: <20230914112954.3067242-1-mailhol.vincent@wanadoo.fr>
 <20230915054815.3130251-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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

When the parsing fails, set the versions number to the maximum
unsigned integer thus violating the definitions of struct
es58x_sw_version or struct es58x_hw_revision.

Then, rework how the es58x_sw_version_is_set() and
es58x_hw_revision_is_set() functions: remove the check that the
sub-numbers are non zero and replace it to a check that they fit in
the expected number of digits. This done, rename the functions to
reflect the change and rewrite the documentation. While doing so, also
add a description of the return value.

Finally, the previous version only checked that
&es58x_hw_revision.letter was not the null character. Replace this
check by an alphanumeric character check to make sure that we never
return a special character or a non-printable one and update the
documentation of struct es58x_hw_revision accordingly.

All those extra verifications are paranoid checks but have the merit
to silence the newly introduced W=1 format-truncation warning [1].

[1] commit 6d4ab2e97dcf ("extrawarn: enable format and stringop overflow warnings in W=1")
Link: https://git.kernel.org/torvalds/c/6d4ab2e97dcf

[2] https://lore.kernel.org/all/CAMZ6Rq+K+6gbaZ35SOJcR9qQaTJ7KR0jW=XoDKFkobjhj8CHhw@mail.gmail.com/

Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
Closes: https://lore.kernel.org/linux-can/20230914-carrousel-wrecker-720a08e173e9-mkl@pengutronix.de/
Fixes: 9f06631c3f1f ("can: etas_es58x: export product information through devlink_ops::info_get()")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/etas_es58x/es58x_core.h   |  6 +-
 .../net/can/usb/etas_es58x/es58x_devlink.c    | 61 +++++++++++++------
 2 files changed, 45 insertions(+), 22 deletions(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.h b/drivers/net/can/usb/etas_es58x/es58x_core.h
index c1ba1a4e8857..f068e47fbc72 100644
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
index 9fba29e2f57c..edd35ba01fb1 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_devlink.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_devlink.c
@@ -34,7 +34,8 @@
  *
  * Parse @prod_info and store the version number in
  * &es58x_dev.firmware_version or &es58x_dev.bootloader_version
- * according to @prefix value.
+ * according to @prefix value. If the parsing fails, set an invalid
+ * version number.
  *
  * Return: zero on success, -EINVAL if @prefix contains an invalid
  *	value and -EBADMSG if @prod_info could not be parsed.
@@ -42,6 +43,11 @@
 static int es58x_parse_sw_version(struct es58x_device *es58x_dev,
 				  const char *prod_info, const char *prefix)
 {
+	static const struct es58x_sw_version sw_version_not_set = {
+		.major = -1,
+		.minor = -1,
+		.revision = -1,
+	};
 	struct es58x_sw_version *version;
 	int major, minor, revision;
 
@@ -63,8 +69,10 @@ static int es58x_parse_sw_version(struct es58x_device *es58x_dev,
 			return -EBADMSG;
 	}
 
-	if (sscanf(prod_info, "%2u.%2u.%2u", &major, &minor, &revision) != 3)
+	if (sscanf(prod_info, "%2u.%2u.%2u", &major, &minor, &revision) != 3) {
+		*version = sw_version_not_set;
 		return -EBADMSG;
+	}
 
 	version->major = major;
 	version->minor = minor;
@@ -85,7 +93,8 @@ static int es58x_parse_sw_version(struct es58x_device *es58x_dev,
  * and 'x' a digit.
  *
  * Parse @prod_info and store the hardware revision number in
- * &es58x_dev.hardware_revision.
+ * &es58x_dev.hardware_revision. If the parsing fails, set an invalid
+ * revision number.
  *
  * Return: zero on success, -EBADMSG if @prod_info could not be
  *	parsed.
@@ -93,6 +102,11 @@ static int es58x_parse_sw_version(struct es58x_device *es58x_dev,
 static int es58x_parse_hw_rev(struct es58x_device *es58x_dev,
 			      const char *prod_info)
 {
+	static const struct es58x_hw_revision hw_revision_not_set = {
+		.letter = '\0',
+		.major = -1,
+		.minor = -1,
+	};
 	char letter;
 	int major, minor;
 
@@ -106,8 +120,10 @@ static int es58x_parse_hw_rev(struct es58x_device *es58x_dev,
 		return -EBADMSG;
 	prod_info++;
 
-	if (sscanf(prod_info, "%c%3u/%3u", &letter, &major, &minor) != 3)
+	if (sscanf(prod_info, "%c%3u/%3u", &letter, &major, &minor) != 3) {
+		es58x_dev->hardware_revision = hw_revision_not_set;
 		return -EBADMSG;
+	}
 
 	es58x_dev->hardware_revision.letter = letter;
 	es58x_dev->hardware_revision.major = major;
@@ -150,29 +166,36 @@ void es58x_parse_product_info(struct es58x_device *es58x_dev)
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
@@ -197,7 +220,7 @@ static int es58x_devlink_info_get(struct devlink *devlink,
 	char buf[max(sizeof("xx.xx.xx"), sizeof("axxx/xxx"))];
 	int ret = 0;
 
-	if (es58x_sw_version_is_set(fw_ver)) {
+	if (es58x_sw_version_is_valid(fw_ver)) {
 		snprintf(buf, sizeof(buf), "%02u.%02u.%02u",
 			 fw_ver->major, fw_ver->minor, fw_ver->revision);
 		ret = devlink_info_version_running_put(req,
@@ -207,7 +230,7 @@ static int es58x_devlink_info_get(struct devlink *devlink,
 			return ret;
 	}
 
-	if (es58x_sw_version_is_set(bl_ver)) {
+	if (es58x_sw_version_is_valid(bl_ver)) {
 		snprintf(buf, sizeof(buf), "%02u.%02u.%02u",
 			 bl_ver->major, bl_ver->minor, bl_ver->revision);
 		ret = devlink_info_version_running_put(req,
@@ -217,7 +240,7 @@ static int es58x_devlink_info_get(struct devlink *devlink,
 			return ret;
 	}
 
-	if (es58x_hw_revision_is_set(hw_rev)) {
+	if (es58x_hw_revision_is_valid(hw_rev)) {
 		snprintf(buf, sizeof(buf), "%c%03u/%03u",
 			 hw_rev->letter, hw_rev->major, hw_rev->minor);
 		ret = devlink_info_version_fixed_put(req,
-- 
2.25.1

