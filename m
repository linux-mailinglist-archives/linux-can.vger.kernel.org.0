Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052CA4DC41D
	for <lists+linux-can@lfdr.de>; Thu, 17 Mar 2022 11:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiCQKmd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Mar 2022 06:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiCQKmb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Mar 2022 06:42:31 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606C81DEC0C
        for <linux-can@vger.kernel.org>; Thu, 17 Mar 2022 03:41:09 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id p8so6457916pfh.8
        for <linux-can@vger.kernel.org>; Thu, 17 Mar 2022 03:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=TSRh9VflwAInYuXwS1EVzqEINHt2oSaGeFzPZ8p2rk4=;
        b=Jj9nehdZYFznNQRFjj6cYt7V9FsIlR/hL6dCT3kQVat+T6xw2UI6l/MglZgoV4mocd
         WAZQfA+jvd3QHSeqKdUD9WlbYdonLulaZDo0B9M3ne0NubTTzvnQH7ff5QCalgL5wZLk
         b5wm9x9+QFoI/w7IZU2zAFrmlZJv7ErdBJ0T6yzqh5iJz8kdiU7J+6pJy4oc7P2s2R/x
         5f5lq2atHlv1hQH2zmcuaZK3GpvNoAG/yuaHhgiRCGovzOVNmkkXZueubxNEaxIl5Lrb
         zJYP7GfLEIoT/OxzFVqvQV0UVQQlVhD7cQgeFFvFnNlQ4S0fI4AjCTjhe2ntBbvVJBpu
         WVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TSRh9VflwAInYuXwS1EVzqEINHt2oSaGeFzPZ8p2rk4=;
        b=007M1RVsahGJp5TFVxNBUwUmstCZ9HQNVce/KHI5uSNj0slUuLLDOJYINDIYMNcpIt
         NYt+X0OKHn5MnbCuMz9ugpo1Xx4WvnTTA9y2rUrcAPG8jp+uNKgsCYXVsdkPWVjJ4Q3P
         XPO3mEeFatq3fNsrklIcxRwKBNxCjNMiKdcd8HJFjtTICwuO6NJtLnZOJwVdwDsnuHP9
         v5uXC3ZArQfN00FmYpkZsXa7jNN57rtq+AdaN0VIQ9CFBjoAVx5NWhCLxGnt9x8ECGKH
         gTJxUORIEwItK8rT4SwMysPyCrXmkMBPR4WbfotDzkyzZapX9NWu9aivimS+PBjU4TQW
         0SDA==
X-Gm-Message-State: AOAM5334SUoKK/ZA21LVP9gQSccgMr2GUBPyWBYKrcGrb0rjn7qcKie+
        cm2EYHIcRoJ1s1MyFPPBoic/9VryLGqXbqMA
X-Google-Smtp-Source: ABdhPJwtytfmyWlK3OzVQ9FSJni8LyKPYeH1DddM1XRR+oy+0KFd5WWiOJDCEkf8UFeiLJ4j1LgOIQ==
X-Received: by 2002:a63:f00e:0:b0:373:9fdb:ce03 with SMTP id k14-20020a63f00e000000b003739fdbce03mr3212904pgh.518.1647513668751;
        Thu, 17 Mar 2022 03:41:08 -0700 (PDT)
Received: from [10.11.37.162] ([103.84.139.53])
        by smtp.gmail.com with ESMTPSA id p12-20020a63ab0c000000b00381f7577a5csm3460920pgf.17.2022.03.17.03.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 03:41:08 -0700 (PDT)
Message-ID: <8bf862a3-2423-b878-8549-7ed5e1799892@gmail.com>
Date:   Thu, 17 Mar 2022 18:41:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] can: m_can: m_can_tx_handler(): fix use after free of
 skb
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20220317081305.739554-1-mkl@pengutronix.de>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <20220317081305.739554-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

I agree with you.

By the way, i find two similar questions about can_put_echo_skb. I hope 
you can also check them out:
mcba_usb:
https://lore.kernel.org/all/20220311080208.45047-1-hbh25y@gmail.com/
usb_8dev:
https://lore.kernel.org/all/20220311080614.45229-1-hbh25y@gmail.com/

They are the same issue as the following patches:
https://lore.kernel.org/all/20220228083639.38183-1-hbh25y@gmail.com/

Thanks,
Hangyu Hua

On 2022/3/17 16:13, Marc Kleine-Budde wrote:
> can_put_echo_skb() will clone skb then free the skb. Move the
> can_put_echo_skb() for the m_can version 3.0.x directly before the
> start of the xmit in hardware, similar to the 3.1.x branch.
> 
> Reported-by: Hangyu Hua <hbh25y@gmail.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> 
> Hello,
> 
> picking up Hangyu Hua's work from:
> 
> | https://lore.kernel.org/all/20220317030143.14668-1-hbh25y@gmail.com/
> 
> Instead of using a temporary variable, move the can_put_echo_skb() instead.
> 
> regads,
> Marc
> 
>   drivers/net/can/m_can/m_can.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 1a4b56f6fa8c..b3b5bc1c803b 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1637,8 +1637,6 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
>   		if (err)
>   			goto out_fail;
>   
> -		can_put_echo_skb(skb, dev, 0, 0);
> -
>   		if (cdev->can.ctrlmode & CAN_CTRLMODE_FD) {
>   			cccr = m_can_read(cdev, M_CAN_CCCR);
>   			cccr &= ~CCCR_CMR_MASK;
> @@ -1655,6 +1653,9 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
>   			m_can_write(cdev, M_CAN_CCCR, cccr);
>   		}
>   		m_can_write(cdev, M_CAN_TXBTIE, 0x1);
> +
> +		can_put_echo_skb(skb, dev, 0, 0);
> +
>   		m_can_write(cdev, M_CAN_TXBAR, 0x1);
>   		/* End of xmit function for version 3.0.x */
>   	} else {
