Return-Path: <linux-can+bounces-2559-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB78BA04B11
	for <lists+linux-can@lfdr.de>; Tue,  7 Jan 2025 21:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8723A493A
	for <lists+linux-can@lfdr.de>; Tue,  7 Jan 2025 20:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38791F63F1;
	Tue,  7 Jan 2025 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="akilUkDe"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF111D958E;
	Tue,  7 Jan 2025 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736282256; cv=none; b=OklaYNDLfHVzTosdzTFuU95e7+5AU05mPCboLg9JuKv/mCPLhDPQ5cgUhibeF4fqJWRi2niI/mfgmdii34wPvqE5Mm1BNYigO99aAOZ2e3jUMKi4rlInF2+PzGhWSDKg05IJbjjepVYksccevF2Hs7FBNH9ArzQ9pNO7x0etjW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736282256; c=relaxed/simple;
	bh=5Jv0GFmrXq1jwYZKh042UJxxjdLs2NPvApOPnl4iIdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dC0aoMPM19W5dYR5LQFSkXjeyzBE4FnMYsux4pq3gRebPfeHoLRMFWeV5dGPxUXGRpNUBIyjiNotXqiq/olO7KJ/TUBnBwqhvk3Bjrq+JJBV/7tI1Sz+pdGx83CIeS0v+ryULQpL2/HGVXVgpJt5ihRgdmtlKMFIQCKGohULqeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=akilUkDe; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2167141dfa1so3100145ad.1;
        Tue, 07 Jan 2025 12:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1736282254; x=1736887054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1H/J3xaLiB+SOTacWZ1CrgmLpcpSfI8SMqoIoJuoKI=;
        b=akilUkDen0HCyHkfOIrH1031pOPPSYkAoh4fynhniaKwxZU1c3o+FpVS7gX5wWZTXb
         BfxjbBKj5RqDeqVdObes++Oj5rxHZUEYj8YamkDS8YfqxfOxKhmHnlfpO9BndzIxyPg2
         h3Rx62qQ5gz+QTmNr0izYFw+jK8sDN5QDFPtvEuH21e/aIsIpUGelhyg8WJDwQ2P4tsq
         d+4tmBEDAQjpuqVuQcIWhb4+vcuqz+SuZAGHPPQGPuXfPe4Vbzqxv/whoFCACP7w8jGL
         Xw3D5cLPULHP0smSh3iapPQAp9hvePRTW+ixp9v/LbJtwTuGjc/2Xa/BwSbmvnMJnzGT
         2AMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736282254; x=1736887054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1H/J3xaLiB+SOTacWZ1CrgmLpcpSfI8SMqoIoJuoKI=;
        b=UNWBezRVzIMOXUQXqks+kl0autodWHPpoTin4khGpGu03H/mFnf/27Ys+mdffHDnR1
         1l8Prfl9W0Qt9qtxnNLbC6+ObBxrSAEKbysmE7qCfof+c+4aJJzjVoaKurfss1PCNMI7
         MsIUK6hTLUlkuiJ6p8wldJ5jyNKeG93BnTHYp0SRrWGEiyohVfLXglQqHmbMfplHwCJr
         aANA6BYmSGyQxLEUc3msBygsb3luvnA/IZxwl/Jj6/R1weALdHMODTkeAhVjqNvY8bHp
         gllO5Yxhh+lVBm3tJIDhWhuk8bPt8TNj2AaNjH1lgdXK8lonHNFewtSIxoMSDofroGkp
         6Jsg==
X-Forwarded-Encrypted: i=1; AJvYcCUY33woubQu0dC94HXMFWzS3IGCS4rTgpZWtRj+mvVxCwCWCN6+A/4zkeVzUNuPgW4NfINGrEAdqVafVeih@vger.kernel.org, AJvYcCUYwH3bDyOZjMUBo7tFArPVGNRyaU4LShrHN+TGr6BHGipbrILKPbkABHc/BVBLEMozDBRYEEJ8BUk5@vger.kernel.org, AJvYcCWRrmao/ZMuBdjlU9KUmizjnARt0sW8Yoiz+m++9vmBVsPo2FBpstIJIlkDb/9gS+DeZY6R9m1dZRHy6s+q4n4=@vger.kernel.org, AJvYcCWv24sI1Slz8sOyCNClGW68lmAjKJpO/mHXypaQL4JAD0vLt/KGriX68ffORqSOcVCFFClUkkvk@vger.kernel.org, AJvYcCXfdpR7Zrys56ex7wU1XpAJFesEqO8cJc0j8aDcbjOpygqigmxBZP4mUtW32+3xNPUYyzOsThCTr5HN@vger.kernel.org
X-Gm-Message-State: AOJu0YwzdhX7F9S0xvkH36dQbt0/i1R5VI4yH6YI54HE4u+sn43rM19/
	lR9fKo8HcSW6PrEdhhhfZ8LOhLVBJxnMRmv2ePUErFLfYI2Ex9Bjt9yptgDi4TiOf9eTMaobVGP
	5HPHvc22NqEXCHBav9wQCW5ipZWw=
X-Gm-Gg: ASbGncvjJobGZJpgJocug5YqYcbaex5To3YkIrK6jRLaTWlHv28AgEdoBYDqJvSqIAr
	T5AbHYx6UDzaT5lVr3A+UNq5+LiMy2ONyZBA59TQZ0AtVtyfeNUNk
X-Google-Smtp-Source: AGHT+IFpy/zEv8gV0glc3e85eskiQiRjVRs6FkoV/+B0RRM/Pns1lF2tiJiK6t7vuZVqLlK8YkI/dPy0Q3JwAvn8b/M=
X-Received: by 2002:a17:903:41c6:b0:215:758c:52e8 with SMTP id
 d9443c01a7336-21a83c148abmr6677255ad.12.1736282254604; Tue, 07 Jan 2025
 12:37:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107125613.211478-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250107125613.211478-1-krzysztof.kozlowski@linaro.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 7 Jan 2025 21:37:23 +0100
X-Gm-Features: AbW1kvYyTE4JPE8j-clACseuWPbFM0gz7gQf2hau2axwDVbwPBqu3atU2f_bDWs
Message-ID: <CAFBinCCwASspnr2u94K=SqTaheS00zwJVjoHOO67-qgw8hNbcg@mail.gmail.com>
Subject: Re: [PATCH net-next] dt-bindings: net: Correct indentation and style
 in DTS example
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Doug Berger <opendmb@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Kalle Valo <kvalo@kernel.org>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Dario Binacchi <dariobin@libero.it>, 
	Christophe Roullier <christophe.roullier@foss.st.com>, 
	Grygorii Strashko <grygorii.strashko@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Roger Quadros <rogerq@kernel.org>, Brian Norris <briannorris@chromium.org>, 
	Frank Li <Frank.Li@nxp.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 1:56=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
>
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/net/amlogic,meson-dwmac.yaml     | 14 +--
For amlogic,meson-dwmac.yaml:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

