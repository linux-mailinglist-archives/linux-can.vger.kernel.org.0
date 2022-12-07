Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2056458AB
	for <lists+linux-can@lfdr.de>; Wed,  7 Dec 2022 12:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiLGLNN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 7 Dec 2022 06:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiLGLMk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Dec 2022 06:12:40 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC0B4E6AE
        for <linux-can@vger.kernel.org>; Wed,  7 Dec 2022 03:11:59 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id d6so28125092lfs.10
        for <linux-can@vger.kernel.org>; Wed, 07 Dec 2022 03:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0iYqJnQf0sSNe9rxshze1YySuIt155ihLOCpKX2z5k=;
        b=wTezHXPaL4l/5HAY8qbeZePY+DKfz3vY1J/a/QnRF3jRMoa2SuHSmVGZG1T2Eifr4W
         rAoaufzCt+/dryglOiGYFvGcmEDATx8y2A3+4h4DV9OV+5+IH5SnJTjNdCEvbGTwG1n/
         GSI7YoV/Hzhx3pK9rKg/E9Xms30rsyWuv8HylCnbFcaw9BF1mdkWNQOUboMEHq7yQoUx
         xSOb6lys3b8s+XQt2ygXBeX2uiukZ6dx7tR/DaTb+wVlu0THe2A/VF/vup1HAtyarn0A
         TU8YYuzvGe+zBMnefoVSlmrudsqJsrJx191X5Rble4bF9bXZ0OncXE23+r3hege/fpzw
         J4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0iYqJnQf0sSNe9rxshze1YySuIt155ihLOCpKX2z5k=;
        b=G7Xz3VO5vKybqFhDRr5XV3ytfCTHiprMuQLZc1dJBP5+BlmrgYaBDTjztprSK4wkyg
         df50hws9KhywqlyJKw/rW2L5GR/cjLsaQd+dhEoBjrTA5m3myQvhCnRf2ksmeAhetb7P
         aQPDYNNfF+kDVTryFQtVD81UDuvZLonLWQGpD/Hm6rXhkrV23Ugt7CrXaO8S0NIulwok
         zB+iNA/H7Wa0HQFV7+ebNX8oHU7EsR/CYibYtMoJ++eiOEm3UQfcPRjFcOMKe8P0ixre
         ZHzsNa7e+B17HVgmySSSje82/e2GTUEpMMyqGUr/cfsD2OfK5bUOeRnDR+8uABWj8W4u
         b+MQ==
X-Gm-Message-State: ANoB5pn4pTyn8cYp19IhCxisxAUgrRwkmWDv2YTCvVXD52WwJb0qsl3J
        JsOxtmaksip4H9C7EdVrhrwJnA==
X-Google-Smtp-Source: AA0mqf4uzvLKyl3k4Pb5t+QyvCxHerRe7zAYZU2BD51W/m4v4FdG4A3Lu0gU1HHRBMujAKiI5F3hBA==
X-Received: by 2002:ac2:4462:0:b0:4b5:7780:cf5a with SMTP id y2-20020ac24462000000b004b57780cf5amr3829606lfl.283.1670411518113;
        Wed, 07 Dec 2022 03:11:58 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 3-20020ac25f03000000b004aa543f3748sm2801528lfq.130.2022.12.07.03.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 03:11:57 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     wg@grandegger.com, pabeni@redhat.com, rcsekar@samsung.com,
        mkl@pengutronix.de, pankaj.dubey@samsung.com, edumazet@google.com,
        linux-fsd@tesla.com, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, ravi.patel@samsung.com,
        robh+dt@kernel.org, Vivek Yadav <vivek.2311@samsung.com>,
        kuba@kernel.org, davem@davemloft.net
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, sriranjani.p@samsung.com,
        linux-can@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        aswani.reddy@samsung.com, netdev@vger.kernel.org
Subject: Re: (subset) [Patch v4 2/2] arm64: dts: fsd: Add MCAN device node
Date:   Wed,  7 Dec 2022 12:11:54 +0100
Message-Id: <167041151082.34325.8017885279639590973.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221207100632.96200-3-vivek.2311@samsung.com>
References: <20221207100632.96200-1-vivek.2311@samsung.com> <CGME20221207100700epcas5p408c436aaaf0edd215b54f36f500cd02c@epcas5p4.samsung.com> <20221207100632.96200-3-vivek.2311@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Wed, 7 Dec 2022 15:36:32 +0530, Vivek Yadav wrote:
> Add MCAN device node and enable the same for FSD platform.
> This also adds the required pin configuration for the same.
> 
> 

Applied, thanks!

[2/2] arm64: dts: fsd: Add MCAN device node
      https://git.kernel.org/krzk/linux/c/142c693e6bd63d8dfaf7f808b015fc46180af731

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
