Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609907A02A5
	for <lists+linux-can@lfdr.de>; Thu, 14 Sep 2023 13:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjINLaP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 14 Sep 2023 07:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjINLaO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 14 Sep 2023 07:30:14 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58204A8
        for <linux-can@vger.kernel.org>; Thu, 14 Sep 2023 04:30:10 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c06f6f98c0so6962225ad.3
        for <linux-can@vger.kernel.org>; Thu, 14 Sep 2023 04:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694691010; x=1695295810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fzgeM3yItx87Msc87WDxMf9CGSNzcl+bol+nOaoQ+Y=;
        b=Y95+ZA8Y3DLbp6LZy+rjnYVOFwrbh0SJYGlmG6w74l6UbJIlx17uPGgpONtGua/i64
         1LjxYmQLGmCEPRAzXmdNTZqcU9XhmPuwtar6lbB+saII6J2Kf3c5Fg76CL7EbVlxmNlH
         8qPp68WItQcx+b9ahRHHhQr7WQRvhXfUHPYSBUZmXwUmB4kPEaozEyk+lj1ETS1zGRRk
         vC1Q10twAoIL+biqD+ql6XuK0HhbDIB0+ABSGeXmiMsIS0TDDXZvFWA5i0Rc8y8ORSeL
         ZTqZ6HULXfqG1ULXWMsFsRNSfEvAvYfn9O0u/wcumzFp1Pulan696Ys5M4r2tfXaeEhV
         w3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694691010; x=1695295810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5fzgeM3yItx87Msc87WDxMf9CGSNzcl+bol+nOaoQ+Y=;
        b=E40om44pw7c6bzfOtzUuStMYHQ2wlLatR3xofD/wPWLE+QL8J+RMDTZyDjIyCa6WCE
         TeLjzQQ8R93Cz/2Fxg+RRMJkig70wWH+Kq/h/mrGyYBeXz/EszhJlveW5nIWkYPKZynG
         ADJhmH7y+zL0vUgkxZI3iytYN+KVsAv/YcKze0hLzKtXF2ANa4Ad5AbzNu6rRb2idn8b
         J8YWUeb+jPtCt+dJriDvmm1+e6tB4Wj3Z+QiLIBJa6nGfn0SCerGHm6q3D5aV2bgqYhP
         9m7s8zGdvDpPY7m0qVOrYZMXBRbUnFM7f+msiY40shtMSqehu1d2N7YexVn+/tt24t46
         BrUA==
X-Gm-Message-State: AOJu0YyxbKeCbVsb+SbROLXtDT3y0n2wKuiPQ6eppqCYld33fWwNjfLO
        F/SrDYIFWU7UIXLKqZa4DiTIgwg866s=
X-Google-Smtp-Source: AGHT+IHG4p8SIMMxKPghiEEGFISWcL8lWRsSszF6p/4LS+5XyNNGg1/tx6WB6nWM9Rv7F/Jj+iaODA==
X-Received: by 2002:a17:902:da86:b0:1bb:a522:909a with SMTP id j6-20020a170902da8600b001bba522909amr5627437plx.37.1694691009666;
        Thu, 14 Sep 2023 04:30:09 -0700 (PDT)
Received: from XH22050090-L.ad.ts.tri-ad.global ([103.175.111.222])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c20d00b001b87d3e845bsm1350765pll.149.2023.09.14.04.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:30:09 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 1/2] can: etas_es58x: silence -Wformat-truncation
Date:   Thu, 14 Sep 2023 20:29:53 +0900
Message-Id: <20230914112954.3067242-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230914112954.3067242-1-mailhol.vincent@wanadoo.fr>
References: <20230914112954.3067242-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

es58x_devlink.c triggers following format-truncation GCC warnings:

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

This is not a actual bug because the scanf() parsing make sure that
the u8 are only two digits long and the u16 only three digits long.
Thus below declaration:

	char buf[max(sizeof("xx.xx.xx"), sizeof("axxx/xxx"))];

allocates just what is needed to represent either of the versions.

This warning was known but ignored because, at the time of writing,
-Wformat-truncation was not present in the kernel, not even at W=3 [1].

Extend the es58x_{sw,hw}_version_is_set() functions to also check that
the versions numbers all fit in the expected number of digits. This
done, rename the functions to reflect the change and rewrite the
documentation. While doing so, also add a description of the return
value.

All those extra verification are paranoid checks but have the merit to
silence the new W=1 format-truncation warning [2].

[1] https://lore.kernel.org/all/CAMZ6Rq+K+6gbaZ35SOJcR9qQaTJ7KR0jW=XoDKFkobjhj8CHhw@mail.gmail.com/

[2] commit 6d4ab2e97dcf ("extrawarn: enable format and stringop overflow warnings in W=1")
Link: https://git.kernel.org/torvalds/c/6d4ab2e97dcf

Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
Closes: https://lore.kernel.org/linux-can/20230914-carrousel-wrecker-720a08e173e9-mkl@pengutronix.de/
Fixes: 9f06631c3f1f ("can: etas_es58x: export product information through devlink_ops::info_get()")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 .../net/can/usb/etas_es58x/es58x_devlink.c    | 38 +++++++++++++------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_devlink.c b/drivers/net/can/usb/etas_es58x/es58x_devlink.c
index 9fba29e2f57c..cb5b55a412d6 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_devlink.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_devlink.c
@@ -150,29 +150,43 @@ void es58x_parse_product_info(struct es58x_device *es58x_dev)
 }
 
 /**
- * es58x_sw_version_is_set() - Check if the version is a valid number.
+ * es58x_check_sw_version() - Check if the version is a valid number.
  * @sw_ver: Version number of either the firmware or the bootloader.
  *
- * If &es58x_sw_version.major, &es58x_sw_version.minor and
- * &es58x_sw_version.revision are all zero, the product string could
- * not be parsed and the version number is invalid.
+ * If any of the software version sub-numbers do not fit on two
+ * digits, a bug occurred and the version is corrupted.
+ *
+ * If all of the version sub-numbers are zero, the product string
+ * could not be parsed and the version number is invalid.
+ *
+ * Return: @true if the sotware version is valid and set, @false if
+ *	it is not set or corrupted.
  */
-static inline bool es58x_sw_version_is_set(struct es58x_sw_version *sw_ver)
+static inline bool es58x_check_sw_version(struct es58x_sw_version *sw_ver)
 {
-	return sw_ver->major || sw_ver->minor || sw_ver->revision;
+	return (sw_ver->major < 100 && sw_ver->minor < 100 &&
+		sw_ver->revision < 100) &&
+		(sw_ver->major || sw_ver->minor || sw_ver->revision);
 }
 
 /**
- * es58x_hw_revision_is_set() - Check if the revision is a valid number.
+ * es58x_check_hw_revision() - Check if the revision is a valid number.
  * @hw_rev: Revision number of the hardware.
  *
+ * If any of the hardware version sub-numbers do not fit on three
+ * digits, a bug occurred and the version is corrupted.
+ *
  * If &es58x_hw_revision.letter is the null character, the product
  * string could not be parsed and the hardware revision number is
  * invalid.
+ *
+ * Return: @true if the hardware version is valid and set, @false if
+ *	it is not set or corrupted.
  */
-static inline bool es58x_hw_revision_is_set(struct es58x_hw_revision *hw_rev)
+static inline bool es58x_check_hw_revision(struct es58x_hw_revision *hw_rev)
 {
-	return hw_rev->letter != '\0';
+	return (hw_rev->major < 1000 && hw_rev->minor < 1000) &&
+		hw_rev->letter != '\0';
 }
 
 /**
@@ -197,7 +211,7 @@ static int es58x_devlink_info_get(struct devlink *devlink,
 	char buf[max(sizeof("xx.xx.xx"), sizeof("axxx/xxx"))];
 	int ret = 0;
 
-	if (es58x_sw_version_is_set(fw_ver)) {
+	if (es58x_check_sw_version(fw_ver)) {
 		snprintf(buf, sizeof(buf), "%02u.%02u.%02u",
 			 fw_ver->major, fw_ver->minor, fw_ver->revision);
 		ret = devlink_info_version_running_put(req,
@@ -207,7 +221,7 @@ static int es58x_devlink_info_get(struct devlink *devlink,
 			return ret;
 	}
 
-	if (es58x_sw_version_is_set(bl_ver)) {
+	if (es58x_check_sw_version(bl_ver)) {
 		snprintf(buf, sizeof(buf), "%02u.%02u.%02u",
 			 bl_ver->major, bl_ver->minor, bl_ver->revision);
 		ret = devlink_info_version_running_put(req,
@@ -217,7 +231,7 @@ static int es58x_devlink_info_get(struct devlink *devlink,
 			return ret;
 	}
 
-	if (es58x_hw_revision_is_set(hw_rev)) {
+	if (es58x_check_hw_revision(hw_rev)) {
 		snprintf(buf, sizeof(buf), "%c%03u/%03u",
 			 hw_rev->letter, hw_rev->major, hw_rev->minor);
 		ret = devlink_info_version_fixed_put(req,
-- 
2.25.1

