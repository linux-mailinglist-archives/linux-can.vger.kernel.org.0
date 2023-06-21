Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0938737FF9
	for <lists+linux-can@lfdr.de>; Wed, 21 Jun 2023 13:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjFUK25 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Jun 2023 06:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjFUK2v (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Jun 2023 06:28:51 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D553F1733
        for <linux-can@vger.kernel.org>; Wed, 21 Jun 2023 03:28:38 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9896216338cso127198366b.3
        for <linux-can@vger.kernel.org>; Wed, 21 Jun 2023 03:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687343317; x=1689935317;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EEz+PLO7wWGAm3nSxnfvXJdbjny/vsgxgeM8/QFXhTw=;
        b=nwXSgD+j9vxn8vdVFzYjX5g68s41Ln+WQ6I8qVhIun1Pjh9jtH/y9lMZoc7qMjiIwY
         PqG9JwWwc8imgvcj0W3BQ+jhHVLDVwwbBe5iqFUgxb01TquQYx3Z1m2zSByBylI5Z9/K
         98TSaDdT78q0SB47m56T8ntCC+HuwwNdh/UP9HPnWIvEdiYhJwQh8NjzmH5YYf8vGJDN
         DQWrKAWwGCLJnmeIJ3SBfMlI440A+czvQoZX0FK2BXQAXjSRM9OR9B5ax67CEtirUdma
         ucOLGzStKD1uHzUZrA+lMRGIuiXLo1HvSM1Msh+HRvarK1RcKsO4Aw96p7HGQEdB7HYC
         m4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687343317; x=1689935317;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEz+PLO7wWGAm3nSxnfvXJdbjny/vsgxgeM8/QFXhTw=;
        b=gE0mpHbgdrZ5SBrNFPRlGV8G/xXxp7mwsSTFxZcq78klTC2phuHU5T6mFr3xiJ23tr
         znXBmDp/9AyO4LiKyCJjgF6xDLViPO1w8A8H2mxGrqn3JkQ/tophrJ30pc7AsS+LIav7
         GBMAUzlIczFj1uBQFTGK6qL5WT64EkVabL4c7Wmd5FTZWy4bALEGsTt9Kc2o3bFXPGSm
         JONiDtlwFvUScgEj4bVl+aWUhHtqOy0S2eEuTuqURjeygvhCxQXxhqfksUnO7BTfPwSp
         kUYXjiJX6smemap8YrZAsBJ+OpIfO/OiPVe56phOdbknNUH8jvsG8BarumI9nhrZ/Lbj
         CQFQ==
X-Gm-Message-State: AC+VfDy8+3EMFByGKy85jQ/SDmfeNmStEozTOGiDBzQ+VBn0E7dP32O9
        izDCZ0TW2p96vvNgKwyz8GjtqA==
X-Google-Smtp-Source: ACHHUZ6f0/qixc74hYOnLdoHW64xh2szrTHHBWV4AlU08bNCkBFtr/Zv2b9LXR6ZCtDRtFHXDSQIzQ==
X-Received: by 2002:a17:907:2d28:b0:973:940e:a01b with SMTP id gs40-20020a1709072d2800b00973940ea01bmr16068426ejc.60.1687343317128;
        Wed, 21 Jun 2023 03:28:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id k21-20020a1709065fd500b009886aaeb722sm2915769ejv.137.2023.06.21.03.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 03:28:36 -0700 (PDT)
Message-ID: <32557326-650c-192d-9a82-ca5451b01f70@linaro.org>
Date:   Wed, 21 Jun 2023 12:28:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 5/6] can: tcan4x5x: Add support for tcan4552/4553
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Vivek Yadav <vivek.2311@samsung.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>
References: <20230621093103.3134655-1-msp@baylibre.com>
 <20230621093103.3134655-6-msp@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230621093103.3134655-6-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 21/06/2023 11:31, Markus Schneider-Pargmann wrote:
> tcan4552 and tcan4553 do not have wake or state pins, so they are
> currently not compatible with the generic driver. The generic driver
> uses tcan4x5x_disable_state() and tcan4x5x_disable_wake() if the gpios
> are not defined. These functions use register bits that are not
> available in tcan4552/4553.
> 
> This patch adds support by introducing version information to reflect if
> the chip has wake and state pins. Also the version is now checked.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  drivers/net/can/m_can/tcan4x5x-core.c | 128 +++++++++++++++++++++-----
>  1 file changed, 104 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
> index fb9375fa20ec..756acd122075 100644
> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> @@ -7,6 +7,7 @@
>  #define TCAN4X5X_EXT_CLK_DEF 40000000
>  
>  #define TCAN4X5X_DEV_ID1 0x00
> +#define TCAN4X5X_DEV_ID1_TCAN 0x4e414354 /* ASCII TCAN */
>  #define TCAN4X5X_DEV_ID2 0x04
>  #define TCAN4X5X_REV 0x08
>  #define TCAN4X5X_STATUS 0x0C
> @@ -103,6 +104,13 @@
>  #define TCAN4X5X_WD_3_S_TIMER BIT(29)
>  #define TCAN4X5X_WD_6_S_TIMER (BIT(28) | BIT(29))
>  
> +struct tcan4x5x_version_info {
> +	u32 id2_register;
> +
> +	bool has_wake_pin;
> +	bool has_state_pin;
> +};
> +
>  static inline struct tcan4x5x_priv *cdev_to_priv(struct m_can_classdev *cdev)
>  {
>  	return container_of(cdev, struct tcan4x5x_priv, cdev);
> @@ -254,18 +262,68 @@ static int tcan4x5x_disable_state(struct m_can_classdev *cdev)
>  				  TCAN4X5X_DISABLE_INH_MSK, 0x01);
>  }
>  
> -static int tcan4x5x_get_gpios(struct m_can_classdev *cdev)
> +static const struct tcan4x5x_version_info tcan4x5x_generic;
> +static const struct of_device_id tcan4x5x_of_match[];
> +
> +static const struct tcan4x5x_version_info
> +*tcan4x5x_find_version_info(struct tcan4x5x_priv *priv, u32 id2_value)
> +{
> +	for (int i = 0; tcan4x5x_of_match[i].data; ++i) {
> +		const struct tcan4x5x_version_info *vinfo =
> +			tcan4x5x_of_match[i].data;
> +		if (!vinfo->id2_register || id2_value == vinfo->id2_register) {
> +			dev_warn(&priv->spi->dev, "TCAN device is %s, please use it in DT\n",
> +				 tcan4x5x_of_match[i].compatible);
> +			return vinfo;
> +		}
> +	}
> +
> +	return &tcan4x5x_generic;

I don't understand what do you want to achieve here. Kernel job is not
to validate DTB, so if DTB says you have 4552, there is no need to
double check. On the other hand, you have Id register so entire idea of
custom compatibles can be dropped and instead you should detect the
variant based on the ID.

Best regards,
Krzysztof

