Return-Path: <linux-can+bounces-710-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051DD8FFA3D
	for <lists+linux-can@lfdr.de>; Fri,  7 Jun 2024 05:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0B728631A
	for <lists+linux-can@lfdr.de>; Fri,  7 Jun 2024 03:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D9117BAF;
	Fri,  7 Jun 2024 03:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4ZwIkd1"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B187179BF;
	Fri,  7 Jun 2024 03:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717731844; cv=none; b=Dy1HmagH/DKBqlIcnz9TMeGu6b32ndmN8BadbSVqOFwo1lRNqHKJx8gF/1W/yH4T9+BbEvDJcyb1bEUl4LPFn8Aj87h6IRJNcvQIrSE2w3K+Y17UTtNFwqClKF9CBRziT+Yx9EMKgmeRZXQAanwlDoAW4r4WG9xjMoTCDPC5X14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717731844; c=relaxed/simple;
	bh=bzGYe9zme902aSDalobT1JW7gwSRULlOseRQbtfbOfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xt1eclLsabAYSStMZXFIBrlWD60URIJWuNfTrrNVHDoWQn70xkQboUv/R5MkNM45nWlPuvX2K/BvGhdxlHls7R8jbKnTiq1zR1D7XFVgmoCL6QC7eaXzuNG1E1pxzVxkNpgpd5QAGM4GNpimjOPv7DNLSAtxmTM62J3ygo1AjVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4ZwIkd1; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70245b22365so1354878b3a.1;
        Thu, 06 Jun 2024 20:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717731842; x=1718336642; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zQGQNI82r6hWdwPRZ6ZShT0PtIt7eTNodTFZSP8T6n0=;
        b=N4ZwIkd16Yowmg5yg7xOXpbfHQk1bqXcxuv1hFVRCcY+uWdyGCf4CCah7AyMdNUMzO
         IAq/vGoPtZd5Klbet3dlIS++0pt3gbm9Wm9DuFRE53xR1uTX9P6T96Etc0ED0qptZ1dw
         bmgsaJJ6HpTI05TS4TD8nkRCrl5uxyo71tq2zT8K1uQuGehQpK5AK92H8XNk4EV2X/JZ
         KfhOz3vR1dj+jV1HmYO0Usb9VX26TGUIFdJSQCutuOtTCfjbWmqk7WhDfEUTNe4xyVCg
         U9bHZ+rN6YVhml9kIFE98WUq3nTQrA8pdvvSdwQciB9yAZTgb9vM0V39q1oZhGlkYg/W
         rjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717731842; x=1718336642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQGQNI82r6hWdwPRZ6ZShT0PtIt7eTNodTFZSP8T6n0=;
        b=aG/ntad+JX2t+2ZR0a3E9cW+OuNEJI/LfvIZMaUfA4gE8N+NB4ZWIEPF1UM1xh4DMV
         pE2SYYuFfsqQVPp2cG7dNo6hgA3DwWA2ayLUabliIB8s66sfsdUCXRYpjBQh8xzS2XJ8
         UlBMc63fHG7N9v1jgS3Dn5uNxrIb5edGL1FYM9WPW6JwGcXHc324sfx0e5tjcOueaiIW
         Y66kU9sFt0jd+ZrXLETFl58pI1VUzw6tENKJ6hMwU6yjwsZxXHN3Nfx0Zsv5zHt3eYgA
         S8an/LFImQ55XQQpB/+TdUN+yXpCdamIwwvLyH8/Uix0NwGCUt/7vzUDqV+cdT7clOQk
         OqPA==
X-Forwarded-Encrypted: i=1; AJvYcCU44cqTlz8X4hA1Mpu9piqvMCV645KcKAo9fDQNkzJhbujHgd1NHGFTQzQJzoF5l9+9wDUnZzKcwWdHsonvivuJfYL+3tsHXL31vfru3qDQx4VJEByJFjRgDgJoMQsTStNAJMWpStfVVGYHGSatjaGNohMBeMleNnFZuheOQB/M
X-Gm-Message-State: AOJu0YzUPSgn4e0MXN7AG9Nf87OeUJfJQbITqnAQPHMg966/XYDD0v3g
	4DOhOgW17O9DVZTvgAdYRHj75jS2n60tuzI6c8KN80ZnJkSGdE6spKM6yDZtFgj8qAdilDGVBdn
	d0urhDXUgaI0lI/3PudoQRJ58p5S/DOKWkZU=
X-Google-Smtp-Source: AGHT+IF0Ze3r78MY2VsoBJF2R64h4SNkTs+W3GZfZO0wUsCuglbj4rmc1ErunNn+SvhUygVmZYTGs7zBhH19jTiQDYQ=
X-Received: by 2002:a05:6a20:734a:b0:1b2:64c2:c224 with SMTP id
 adf61e73a8af0-1b2f9a7f377mr1671081637.34.1717731842210; Thu, 06 Jun 2024
 20:44:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606141222.11237-1-Harald.Mommer@opensynergy.com>
In-Reply-To: <20240606141222.11237-1-Harald.Mommer@opensynergy.com>
From: Vincent Mailhol <vincent.mailhol@gmail.com>
Date: Fri, 7 Jun 2024 12:43:51 +0900
Message-ID: <CAMZ6RqK+doMKZfsbchHsfo9xYdEoKGyQk035PHbiW0quWFM+sg@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio-can: Add link to CAN specification from ISO.
To: Harald Mommer <Harald.Mommer@opensynergy.com>
Cc: virtio-dev@lists.linux.dev, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>
Content-Type: text/plain; charset="UTF-8"

On Thu. 6 Jun. 2024 at 23:26, Harald Mommer
<Harald.Mommer@opensynergy.com> wrote:
> Add link to the CAN specification in the ISO shop.
>
>   ISO 11898-1:2015
>   Road vehicles
>   Controller area network (CAN)
>   Part 1: Data link layer and physical signalling
>
> The specification is not freely obtainable there.
> ---
>  introduction.tex | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/introduction.tex b/introduction.tex
> index 8bcef03..72573d6 100644
> --- a/introduction.tex
> +++ b/introduction.tex

Excuse my ignorance, this is not a patch toward the Linux tree, right?
Could you let me know which git tree this patch is targetting?

> @@ -142,7 +142,8 @@ \section{Normative References}\label{sec:Normative References}
>      TRANSMISSION CONTROL PROTOCOL
>         \newline\url{https://www.rfc-editor.org/rfc/rfc793}\\
>         \phantomsection\label{intro:CAN}\textbf{[CAN]} &
> -    ISO 11898-1:2015 Road vehicles -- Controller area network (CAN) -- Part 1: Data link layer and physical signalling\\
> +    ISO 11898-1:2015 Road vehicles -- Controller area network (CAN) -- Part 1: Data link layer and physical signalling
> +       \newline\url{https://www.iso.org/standard/63648.html}\\
>  \end{longtable}

I just realised that ISO 11898-1:2024 was published last month:
https://www.iso.org/standard/86384.html.

Just for confirmation, are you keeping the reference to ISO
11898-1:2015 until CAN XL support gets added? If yes, OK as-is.

On my side, I now need to read the new ISO 11898-1:2024.

>
>  \section{Non-Normative References}
> --
> 2.34.1
>
>

