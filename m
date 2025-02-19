Return-Path: <linux-can+bounces-2883-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88908A3C51C
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 17:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB09C169899
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 16:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E1F1F8F09;
	Wed, 19 Feb 2025 16:34:23 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE4B1FCCFD;
	Wed, 19 Feb 2025 16:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982863; cv=none; b=WlBW1agKvZXS5L9eSL6zq/v/tAL2rqmB9aUsNYyL7HTrnGoP2QhGrNbVk2/raqAQQvYIVtiQfWmHzq823zz0Y4xqheZMqojfd05WF8JTIy8qgkaEsca7Jp4FpSUKUUfnEzCZQ2/ZwxcG2hmpr1Tsr3Xudf7a0+VPbu1s3cktPfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982863; c=relaxed/simple;
	bh=MLn/TsMQt4X+QK4e4bv/A73rL+NUmccpwtnK7bATrM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+CZe85UPbq2H8eNgBv1LULmPbb/hxPULp47YXnbNcuikjhMDbVMskWxD7WkQh7mURxmbuhjZsL4cHzwmOd8gTJUR2gfOS17gW+Y+3YLX8w87YFim2SpebDa6P8tBFfIEr0lvHKTeA7glbr98A2Rg65XxW4OeVnyaaNK0wDQYXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5209ea469e9so720507e0c.0;
        Wed, 19 Feb 2025 08:34:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739982860; x=1740587660;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hacM/z7DmOrcgAPzrrWmLbrCAspM7o/nQgW8vja8iQs=;
        b=X7xpMcZ7Hy5bBSg6/zzhEy71rDVoaydrxW7ree4KS2ohT+XJ41Zl84jBtLSb1mMbgC
         t4qpdkdjuER65c3QcyyxO2AFmdh/EFsuce/oMN6x+1+V4Qpdx4zdhYnGevJAwgcs205c
         WQuF8K/joEcO9X1ORiLBAEP2NZ4CK8Pz/hjKgWAE5p5vpPxlhKV8yk3oqXA+6J/mqNgo
         ZfbHB0RDwgphFGsAjVgDdCxStdSYXgxYZ8U+eAL73+nb6XpWWyvW2rtPInvWjZMKOBtE
         WcUEBqFcqLRDC0FTyxb5TgKDsM7dcHjX8XRkG9C85X9GVV4a0ySifGYiBW3gQ+ttYrFh
         Z3cw==
X-Forwarded-Encrypted: i=1; AJvYcCX8hQrTkrJ9UviIggK0EWQGO79zmu72O3zXztcmqc0aXuqxMHBa/bDL1mnkExr/jJcXtieInVfyVdCvSH1klpQDSf8=@vger.kernel.org, AJvYcCXeuLc6ESi03J8+yKuUamHma/U1KpbSXe8dQ4QPxcs2knKNZyITtStFAZkn3i7Sk8Zv0J+A2oYAlmOoyH1t@vger.kernel.org, AJvYcCXuolElMuXqMhxkfgMl/oWyDN7uyuRp1dT5v5lSFVYFgFoFrb6ipYMiIApV+RGMjEcG3G/fydmvdDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFdJPW7okY0Fe6jw8/kZZ3CuRaUL5St1AkLUiaD5K/VNPLV71G
	vwG8DF8CUCraOeATVnMRxBieUEW5xErNIHNQW4n9f2+KWSVkhbndX6Luh3z4
X-Gm-Gg: ASbGncv6Fm4QgZDHRduzpMvEt60qPrg5mCp3kIa103Ew+qUwUD/kMPOI7+aIroVR12F
	Hnth3tzSnewos/7Tzey7bBaZCjx/kWfzr8VGqA6rOiW3MAEZNq7Nei7YC1gDpuNnB1xEIK/RdEA
	wwDJUE3tzZ2e3D7ztyho7NPTrDKqjlgv3y3Xb3g06rHSJKVUpVa/AGh5aW1YxqB12V2AU1LZOyy
	dygOqdFMLo0ghN6QK6hPtbNvbPJkBGyXbM5MlJHgGEbjCwBrCK3QwMWQsFp6MTou2uqsO5+bkjz
	AGdEVEEQe3bjzkV1xReGte0YoRxNpxIT47aPrSaxxBnzo0QD0Y9Hcg==
X-Google-Smtp-Source: AGHT+IHFQNicUVplijknqpU4/ZGVVg91BOV/WZKk2b3/Z771WqCQJONHE4vuZAmvNFrumZG4K0+iQw==
X-Received: by 2002:a05:6122:4b87:b0:520:4fff:4c85 with SMTP id 71dfb90a1353d-521c3229af0mr3195726e0c.2.1739982859607;
        Wed, 19 Feb 2025 08:34:19 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-520b0ff2c9fsm1898181e0c.35.2025.02.19.08.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 08:34:19 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-866e8a51fa9so4885241.1;
        Wed, 19 Feb 2025 08:34:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8fNerlTIRWSoX+t7Vn8vZe3Sluh78A5zHj8pygS82PAyqtJmuYDCQlsy3BrMq8jNDuik9/WZXwII=@vger.kernel.org, AJvYcCWDMzBcfT0VkU4i2muziQnf7UTX5ZgzhBXH8q4VW8gkVudgwMzmJLAiJ1Su+jH7//Qvoc+UrZf5RmFiuS+L@vger.kernel.org, AJvYcCXPmjySxSk5Y1aMA+D57D9dHWfAwo7v1HwvfEqXasQ3r8iViiYs1GLytE/Gk28Kkt1AWIGDAM0Yv/9l34zDDCs2/vE=@vger.kernel.org
X-Received: by 2002:a05:6102:dc9:b0:4be:6151:dfd8 with SMTP id
 ada2fe7eead31-4be8454777dmr3305014137.10.1739982858747; Wed, 19 Feb 2025
 08:34:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203185421.3383805-2-robh@kernel.org>
In-Reply-To: <20250203185421.3383805-2-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Feb 2025 17:34:06 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW26JDM+BDq8+vyJG2c316ZoF9ODmCfF4KfwJFJe6B7sA@mail.gmail.com>
X-Gm-Features: AWEUYZkP0St8Copel6sogy2IZLCNjeA2BBkvxODARj1xkKGB-fmyHYIPZ2_fXLo
Message-ID: <CAMuHMdW26JDM+BDq8+vyJG2c316ZoF9ODmCfF4KfwJFJe6B7sA@mail.gmail.com>
Subject: Re: [PATCH] phy: can-transceiver: Drop unnecessary "mux-states"
 property presence check
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Rob,

On Mon, 3 Feb 2025 at 19:55, Rob Herring (Arm) <robh@kernel.org> wrote:
> It doesn't matter whether "mux-states" is not present or there is some
> other issue parsing it causing an error. Drop the presence check and
> rework the error handling to ignore anything other than deferred probe.
>
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> Now a warning in v6.14-rc1, so please apply for 6.14.
>
> v2:
>  - Use brackets on else clause

Thanks for your patch, which is now commit d02dfd4ceb2e9f34 ("phy:
can-transceiver: Drop unnecessary "mux-states" property presence check")
in phy/next (next-20250212 and later).

I have bisected the following error during boot on the Gray Hawk Single
and White Hawk development boards:

    can-transceiver-phy can-phy0: /can-phy0: failed to get mux-state (0)

> --- a/drivers/phy/phy-can-transceiver.c
> +++ b/drivers/phy/phy-can-transceiver.c
> @@ -113,13 +114,11 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
>         match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
>         drvdata = match->data;
>
> -       if (of_property_read_bool(dev->of_node, "mux-states")) {
> -               struct mux_state *mux_state;
> -
> -               mux_state = devm_mux_state_get(dev, NULL);
> -               if (IS_ERR(mux_state))
> -                       return dev_err_probe(&pdev->dev, PTR_ERR(mux_state),
> -                                            "failed to get mux\n");
> +       mux_state = devm_mux_state_get(dev, NULL);

If the (optional) "mux-states" property is not present, mux_get()
prints an error message, and returns -ENOENT....

> +       if (IS_ERR(mux_state)) {
> +               if (PTR_ERR(mux_state) == -EPROBE_DEFER)
> +                       return PTR_ERR(mux_state);

... which is ignored here, so in the end all is good.
Still, it is confusing to erroneously print an error message.

> +       } else {
>                 can_transceiver_phy->mux_state = mux_state;
>         }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

