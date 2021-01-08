Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C7D2EEDF1
	for <lists+linux-can@lfdr.de>; Fri,  8 Jan 2021 08:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbhAHHkY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Jan 2021 02:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbhAHHkY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Jan 2021 02:40:24 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01924C0612F4;
        Thu,  7 Jan 2021 23:39:44 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i9so8025755wrc.4;
        Thu, 07 Jan 2021 23:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=c5P+vvdX7z4Mp5Q7UAxuVpXv4FhDjOB40VptQJQFkP8=;
        b=ULcPG7pG3hfb4RaCCdNWz8cGe/83A/1O4EhCZZuR85Zw/37aUPVEbsyX2NP4o7pV7Y
         YgaN7jW7IfTxRYJIi6gS1L/KZ2BHYUBVAxFMXXL2BScQ6d3Iinjpp6JlfYbMPZQHuTCR
         dAhxYci+RBDU9jMf+d4pFm0FIzmrHwYoXdPBqaTs+PbSiEMUWGcssQ5woavK7Hgx76ia
         6sn1VWGWM5yQuRw5aCL7yC6tsoitzHI5pJhALfIpf0ULe4zoC5HG1Q5GgybKrj5OMOXp
         FsoIZYNwQ0P8xgazLZZZKRp9CgfFqvFSu2XtFRTNM7JzUIErBffGvCd8BSt4rPmyjAk6
         lEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c5P+vvdX7z4Mp5Q7UAxuVpXv4FhDjOB40VptQJQFkP8=;
        b=Bbmsn28yom6WZnFosoW95WpVFhsCK+HQXcl78QJ4l2LvjcXWrK1UsY59GXiZ8dspne
         Pm8POAuW+910dA9bbwFf3fmfOQ7J9elrz8mzBEffj80Hz6Qe2eM6iR+IcZRoMQKTwiMD
         pnXh0OrU6OL56PiJpVPf9aC//4sO0G0ZiTnCWZMoIof8C9lSEbHLjodSngDSNE6c3XLi
         OqICcCQ8G91j02fRQD2vRXkKH0CY9fBUJTyVsb3H5gjA7sXcxAB1sxkvJrTLJMcgWod2
         ZeE52F4pKLW+JI+MoRQsUAikyHhKj8ibh9vfo2qpPOP0nKooQEdluqWtnA+iCdkeVIws
         EJgQ==
X-Gm-Message-State: AOAM530cgDdTYjh2SNGfZJ8vOzRyMVif0FVAW4hKTxWhoMF9c/svU/Lg
        1nqH9MBowY92JVPAH2lefis=
X-Google-Smtp-Source: ABdhPJyPwtYCwKwbl9aqmXccDodCIGu87EsclY/46H4yL3ExGm0bY2bMvlfX5nOmTTnNZkwgkK0Mbg==
X-Received: by 2002:adf:e511:: with SMTP id j17mr2258610wrm.416.1610091582663;
        Thu, 07 Jan 2021 23:39:42 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2dc3:3e00:c96a:15b:2758:58ec])
        by smtp.gmail.com with ESMTPSA id x18sm13895152wrg.55.2021.01.07.23.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 23:39:41 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>,
        Sriram Dash <sriram.dash@samsung.com>,
        Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH for can-next] MAINTAINERS: adjust entry to tcan4x5x file split
Date:   Fri,  8 Jan 2021 08:39:32 +0100
Message-Id: <20210108073932.20804-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Commit 7813887ea972 ("can: tcan4x5x: rename tcan4x5x.c -> tcan4x5x-core.c")
and commit 67def4ef8bb9 ("can: tcan4x5x: move regmap code into seperate
file") split the file tcan4x5x.c into two files, but missed to adjust the
TI TCAN4X5X DEVICE DRIVER section in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches    F:    drivers/net/can/m_can/tcan4x5x.c

Adjust the file entry in MAINTAINERS to the tcan4x5x file splitting.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20210107, not for current master

Marc, please pick this for your -next tree on top of the tcan4x5x cleanup.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8170b40d6236..0d75f07fc951 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17887,7 +17887,7 @@ M:	Dan Murphy <dmurphy@ti.com>
 L:	linux-can@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/can/tcan4x5x.txt
-F:	drivers/net/can/m_can/tcan4x5x.c
+F:	drivers/net/can/m_can/tcan4x5x*
 
 TI TRF7970A NFC DRIVER
 M:	Mark Greer <mgreer@animalcreek.com>
-- 
2.17.1

