Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23123631F5E
	for <lists+linux-can@lfdr.de>; Mon, 21 Nov 2022 12:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiKULIM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Nov 2022 06:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiKULGx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Nov 2022 06:06:53 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038204E43E
        for <linux-can@vger.kernel.org>; Mon, 21 Nov 2022 03:06:28 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id s8so18266351lfc.8
        for <linux-can@vger.kernel.org>; Mon, 21 Nov 2022 03:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFWc0lyVlH95oooJGcIUPfd8EfwgVQvFO8qkEV+ffsc=;
        b=r7hKUlGFZHSmUo8e9T5ttNSJVAtUIkxa+sycNhz6yjMvfgsi4BsfKebzRywymxymx0
         5u8F1YiUTZQCXcqMn0sfhionqeBApbXWdupVJzyFaxfv5GrU+U3eV6uFF8Uc+bn9QYY9
         Lms8Y8Dy0jualOb6Q3esqic3f7gurcqjMFZcZ+d9NzQOJ86H32u/XDiWQ2YkDuliRZvv
         nRAaqsKnXNUtg68nfvEmkjWN8H79Sk3dDjy/u/sisLO3c+s0yeylT32uwz3f7gvWfFaj
         gF7udl05HElld877JkEGkfP5OdFi8KqGkr7SLX3btVOqu0mHwPCN9Sin0XvK+TjDxtSD
         nJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFWc0lyVlH95oooJGcIUPfd8EfwgVQvFO8qkEV+ffsc=;
        b=NV9NLk61wRLmBsp7PPD9/ErEnCUN+4DJnUODskcbi5BPG5S2NnoQDIihzSDrL3VnUe
         tZMJiI0rVI3B8FyxorWw6XU9/dvjWNJjXf1g6k3Ni1eB5uImB6vRPc7PwayZG/6iYOWB
         JRecU89PPp6Jd5jQSyjUM9+MHrFu6LiRg7fpd4bk7uLtQ0Qbag7T/w17CULWGpXnxTrc
         cD8sf4hKBCk+0U2E7IOlDoUiQUJt/+lOyHcKnv4Zx9Ne2ZwlkXjCg5JA4hu+pHlS+3Eo
         iFv/UTS48a+P7PblWx0Sy4mSaJ8CK5r3nZ1DugqrL9XbaZyjHED3xUuY497xN/djdHgS
         aasA==
X-Gm-Message-State: ANoB5pms88nAqYnacFDDksNc184WSLwQBUtJoIGwEKwcPRV95yNdROEm
        OP0M4DK0S2CenIpXsnRDAgep8g==
X-Google-Smtp-Source: AA0mqf636Kajsl/vCtaPitrxYhf2ypiEKfsGbHJhGytuU/U+YWfw7NKkZ181BWLvvcggxq6Qzec5vw==
X-Received: by 2002:a19:dc08:0:b0:4b4:6460:24d with SMTP id t8-20020a19dc08000000b004b46460024dmr5540013lfg.386.1669028786293;
        Mon, 21 Nov 2022 03:06:26 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id n1-20020a05651203e100b0049313f77755sm1991521lfq.213.2022.11.21.03.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 03:06:25 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-can@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-watchdog@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 3/9] dt-bindings: clock: st,stm32mp1-rcc: add proper title
Date:   Mon, 21 Nov 2022 12:06:09 +0100
Message-Id: <20221121110615.97962-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221121110615.97962-1-krzysztof.kozlowski@linaro.org>
References: <20221121110615.97962-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add device name in the title, because "Reset Clock Controller" sounds
too generic.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
index 242fe922b035..5194be0b410e 100644
--- a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
+++ b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/clock/st,stm32mp1-rcc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Reset Clock Controller Binding
+title: STMicroelectronics STM32MP1 Reset Clock Controller
 
 maintainers:
   - Gabriel Fernandez <gabriel.fernandez@foss.st.com>
-- 
2.34.1

