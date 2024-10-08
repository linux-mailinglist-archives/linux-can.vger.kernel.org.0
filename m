Return-Path: <linux-can+bounces-1609-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97920993CF8
	for <lists+linux-can@lfdr.de>; Tue,  8 Oct 2024 04:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47E821F25EE1
	for <lists+linux-can@lfdr.de>; Tue,  8 Oct 2024 02:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDD91EA85;
	Tue,  8 Oct 2024 02:38:03 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BFE1E519;
	Tue,  8 Oct 2024 02:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728355083; cv=none; b=o+y8RXBytd+UJqbRuQqhGWYLB0oXE8nJJvoC6HMe89dBazx+q1HCn3bBYSBMsCbxTHpOUG1OpuLA7PndEqeu7gzyHS3aeE6cjEdNKOfHDDwVhdVnHaYH++7DkII/VWBPh0ogFMlrlVqDHqJPile48h2V0ZhHT16d/Z2wUKMCShU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728355083; c=relaxed/simple;
	bh=WW2ZUn8u2My6hs7NnhXV8bAjic0FhqY7KCEKtOrTVuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVODEFp7I8e4SqdQF1AccFkl3Y8dUFHYbGGkhzc0boVLCKkopQSS895H2NTWthA4rFDbJPqzvYlXMI5qo1KW8/KD9tTxXbcAjTXiVgTU2YGCS3pS2z4N4dCiTk9qqUQ32kIkSK/TYfgyEg7wmsqWfmBv+AwG1hrtV39/fpPBh3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9939f20ca0so415618666b.1;
        Mon, 07 Oct 2024 19:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728355080; x=1728959880;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ke3ubpcD3osJaNCrpOlt3py5KxVXEbchLbS93eRcvKY=;
        b=XlGj2dRwO8ZllmXnMUts+xd0eBoPTiGVs+DMaYjCv6GNS3Ohdg4J3vaCI4QX+T80eq
         jgzBANrVsLYXKXp4s2kYkB90I+gwr4p2Oxd2xJqRl955qmRLiwrruHFPZNHNAOZjzEKY
         9lzI779FJx6X0fk82hcm8UoRfTavsCIpHnxRkcpRp4MTikjkQrQJxYiBeeGb5dI5gy5m
         u9NA+FOS7Sz/OtczhkYlIaDxPHggnQnlgTaZazBCD+ECdVXO6rvkkCFQyWesswY3EuxG
         Tdzrdreh38UQroxqXeazI1gSSrVp22K3iWr18K2J7zgujzOQThHMx9fl/qsQBe++uP1l
         3lJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnUGljgmBVe6tsN6LqK4AZT+edepG+4y83bFHldJZoKJoCUZNXTlVOQ8ZlOZlfLijjT8JNuK3omsqckb5P4Mg=@vger.kernel.org, AJvYcCUnqDwcUUM5WprSf+szaonvC2XbpdNXQc2eqJsKqB2KLh7VSJ/FfNMT7gik5ZuEe2GMni5QfGEf@vger.kernel.org, AJvYcCUxIU/LJPgt4lTcUWB1nkYY91NsqAzZRaxz3T2E6OLxwgMIkmVvUkhnqTe7Kqn/NMwemHGfM7x7B9vlHuab@vger.kernel.org, AJvYcCVyIa4j7/hWw8erbiiHACEm0DMNvJG78WXCMqIeQQpOWFFE1pfVA2zogekbDfTGdJuHQ7GjBpnE0b+N@vger.kernel.org, AJvYcCWg8kkQYpv4iBETTyiXzJFaB0O71rvOeayg2hN3CGofKTippWiuBsYL+jON4uWy3ChWhz4IgLqIFI5yHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfnaQgQ6/Mwh2K46If/wDWVSvUqyre+n1n46pR3LSMdyO7EC4s
	LBNcP6qBlyP+fjasZefwPPR1ScHg6T49/Q0zsi3ibP6owE6fmOJHYY4erneTN65xmReK9StZtsj
	/or7BofxrcPJgAZsHtHkJSRSwnmo=
X-Google-Smtp-Source: AGHT+IFXmydTBmkkSaf40+Ze2UTWmmKekmldHWYwKhoyK4SHBy47nIJl5jVO3HA66TgMJGJUbU0WGOZYfXzO4gxmpcw=
X-Received: by 2002:a17:906:6a1e:b0:a99:742c:5b5 with SMTP id
 a640c23a62f3a-a99742c4745mr54460866b.13.1728355079975; Mon, 07 Oct 2024
 19:37:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007213502.28183-1-ignat@cloudflare.com> <20241007213502.28183-6-ignat@cloudflare.com>
In-Reply-To: <20241007213502.28183-6-ignat@cloudflare.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Tue, 8 Oct 2024 11:37:48 +0900
Message-ID: <CAMZ6RqJ8XBVd5RzKEtxKz8hp9sR7g6fzwLv_3aB1OUSuK_dBFA@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] net: af_can: do not leave a dangling sk pointer in can_create()
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-wpan@vger.kernel.org, 
	kernel-team@cloudflare.com, kuniyu@amazon.com, alibuda@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hi Ignat,

Thanks for the patch.

On Tue. 8 Oct. 2024 at 06:37, Ignat Korchagin <ignat@cloudflare.com> wrote:
> On error can_create() frees the allocated sk object, but sock_init_data()
> has already attached it to the provided sock object. This will leave a
> dangling sk pointer in the sock object and may cause use-after-free later.

I was about to suggest that this should be backported to stable, but
after reading the cover letter, I now understand that this patch is
more an improvement to avoid false positives on kmemleak & Cie. Maybe
the description could be a bit more nuanced? After patch 1/8 of this
series, it seems that the use-after-free is not possible anymore.

> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>

See above comment as notwithstanding. This said:

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>


> ---
>  net/can/af_can.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index 707576eeeb58..01f3fbb3b67d 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -171,6 +171,7 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
>                 /* release sk on errors */
>                 sock_orphan(sk);
>                 sock_put(sk);
> +               sock->sk = NULL;
>         }
>
>   errout:
> --
> 2.39.5
>
>

