Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E75332D3A
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 18:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhCIR2M (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 12:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbhCIR1o (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 12:27:44 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494DBC06174A;
        Tue,  9 Mar 2021 09:27:44 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id k9so28337555lfo.12;
        Tue, 09 Mar 2021 09:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E0L24YzwE+RwXtp71i5Fz7XoP/XCEU0C3pgyRyLsjJE=;
        b=tS2mj4X1C5n+8Mg4kcTRAsr1vZpnFfjT+mOLqUUPBoxeto0tLvrHSfqPlbjpe5YqOZ
         Gk7Cnlfh3h3ueQA5pntdcDXHvHEU/6Y2M7zwanh7FB9fVoGnW2J6/IzoLJK33hTbgz9L
         ZjCXvk/36ceJyirXGmduwixPo2uKV9hpSwNusiflQREJAgMxIcsDDqUYUUSyCbslFJ7m
         d8zWFw3Y+qM5EmAJdKJRdqr2mqlUud1joRNMC3igRS3V2nlGDizKIzRyR3rWjVnCi1SX
         Dcy3xrkOoGxrk1/4sd+NfF2GyNJHONZavEHDbaVcOBU3GP549qdVn/fPci1NQ7p7IwkG
         KZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E0L24YzwE+RwXtp71i5Fz7XoP/XCEU0C3pgyRyLsjJE=;
        b=ZXRsa9aNWKjnJ1iRsh98N7+Ifh1Juzf1IABcabItTIjq8unV9gkaGzoe5W7mIQl53D
         i9jr3JWvH6J3JckCBfs1fqTgm0Ud21qQ6WdK9HbdupQequFQkw88xVS322lBr/VGKiPu
         n+tUL60FxiKx9nn+PY9JexTANsG0++3RmImOrEgE030Ej9Rl88SH3B/uKymBos3uq2O7
         L3or1+TetPpv2CAhEpRacva2aPUE4MAJzgC+rq43GDVgY/mkdQBLEgYjOdXLD3vfW3Py
         G6unZIRoZ/C7WZAG0fFKnxATbW5BIkmgIkebxzV5h7PBuHWw5dJYrEyPOvXq9DZnrIRI
         H0Ig==
X-Gm-Message-State: AOAM533/4wP83i4OojGIkp6aHi1OkqSW33zoYjhffFb67Eu1z4LNYTft
        n3PPaRYeIIyDZuCJ1KNHFMsXHqdgD0LmOg==
X-Google-Smtp-Source: ABdhPJxFsbanWV4cxKzbfa0Zq/aoMWOTsEXWKIPVPKiBEoIBkz9EqJoATFcDUiu/K7QPILiAG4qebg==
X-Received: by 2002:a05:6512:51c:: with SMTP id o28mr19019898lfb.237.1615310862860;
        Tue, 09 Mar 2021 09:27:42 -0800 (PST)
Received: from [192.168.16.194] (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.googlemail.com with ESMTPSA id m6sm2026164lfb.150.2021.03.09.09.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 09:27:42 -0800 (PST)
Subject: Re: [RESEND v12] can: usb: etas_es58X: add support for ETAS ES58X CAN
 USB interfaces
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        linux-kernel@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
References: <20210309120946.1640-1-mailhol.vincent@wanadoo.fr>
 <20210309120946.1640-2-mailhol.vincent@wanadoo.fr>
From:   Jimmy Assarsson <jimmyassarsson@gmail.com>
Message-ID: <45c0b0cc-bfd6-5180-7ad9-51eebc9de3c9@gmail.com>
Date:   Tue, 9 Mar 2021 18:27:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20210309120946.1640-2-mailhol.vincent@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Vincent,

On 2021-03-09 13:09, Vincent Mailhol wrote:
> This driver supports the ES581.4, ES582.1 and ES584.1 interfaces from
> ETAS GmbH (https://www.etas.com/en/products/es58x.php).
...
> diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
> new file mode 100644
> index 000000000000..31f907a7b75f
> --- /dev/null
> +++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
...
> +/**
> + * es58x_add_skb_idx() - Increment an index of the loopback FIFO.
> + * @priv: ES58X private parameters related to the network device.
> + * @idx: address of the index to be incremented.
> + * @a: the increment. Must be positive and less or equal to
> + *	@priv->can.echo_skb_max.
> + *
> + * Do a modulus addition: set *@idx to (*@idx + @a) %
> + * @priv->can.echo_skb_max.
> + *
> + * Rationale: the modulus operator % takes a decent amount of CPU
> + * cycles (c.f. other division functions such as
> + * include/linux/math64.h:iter_div_u64_rem()).
> + */
> +static __always_inline void es58x_add_skb_idx(struct es58x_priv *priv,
> +					      u16 *idx, u16 a)

Never used?

...
> +/**
> + * es58x_get_product_info() - Get the product information and print them.
> + * @es58x_dev: ES58X device.
> + *
> + * Do a synchronous call to get the product information.
> + *
> + * Return: zero on success, errno when any error occurs.
> + */
> +static int es58x_get_product_info(struct es58x_device *es58x_dev)
> +{
> +	struct usb_device *udev = es58x_dev->udev;
> +	const int es58x_prod_info_idx = 6;
> +	/* Empirical tests show a prod_info length of maximum 83,
> +	 * below should be more than enough.
> +	 */
> +	const size_t prod_info_len = 127;
> +	char *prod_info;
> +	int ret;
> +
> +	prod_info = kmalloc(prod_info_len, GFP_KERNEL);
> +	if (!prod_info)
> +		return -ENOMEM;
> +
> +	ret = usb_string(udev, es58x_prod_info_idx, prod_info, prod_info_len);
> +	if (ret < 0) {
> +		dev_err(es58x_dev->dev,
> +			"%s: Could not read the product info: %pe\n",
> +			__func__, ERR_PTR(ret));

Missing free

> +		return ret;
> +	} else if (ret >= prod_info_len - 1) {
> +		dev_warn(es58x_dev->dev,
> +			 "%s: Buffer is too small, result might be truncated\n",
> +			 __func__);
> +	}
> +	dev_info(es58x_dev->dev, "Product info: %s\n", prod_info);
> +	kfree(prod_info);
> +
> +	return 0;
> +}


Regards,
jimmy
