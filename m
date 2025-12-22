Return-Path: <linux-can+bounces-5902-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE59CD6DC9
	for <lists+linux-can@lfdr.de>; Mon, 22 Dec 2025 18:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1570301C3E9
	for <lists+linux-can@lfdr.de>; Mon, 22 Dec 2025 17:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA02338595;
	Mon, 22 Dec 2025 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNa3vbgR"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AB531281D
	for <linux-can@vger.kernel.org>; Mon, 22 Dec 2025 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766426250; cv=none; b=ToA0Cpr6zVftDeFEH/7MHHZosRQRvLz/tZeT+q1vYfQCEqMnT90npoFBVT3Q83dOaY2jr+WO0jIkgDq+yNmN9kx5fc+sSz+9U+37TEwjzfkd6YS0zV8VO+dsUSlgxTMoEZFOjCGjLbDE16nl9JFBCjj3SdKvX8odRa7mkCYnThQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766426250; c=relaxed/simple;
	bh=wBha3d01qjiMew7UlnJKYluL6OwpP6oM7rEy/5DQKRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlmV9So6ZfGhuvxckVwODT6O3yQeHDWB17CFZxjdfOFb90OPIR7fWclVMk/11bCmTg8hq7rJ0EVpmUv4Sb0jMtXBPbgdko4giNsNNTeTaZhV9mLvEANGDKMaEGzpfhpHL4UIBBjFTeIReIJ8f5C0D+cq9WhAlR6uvwMjm3v5oDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNa3vbgR; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b736ffc531fso752255266b.1
        for <linux-can@vger.kernel.org>; Mon, 22 Dec 2025 09:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766426247; x=1767031047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBha3d01qjiMew7UlnJKYluL6OwpP6oM7rEy/5DQKRo=;
        b=LNa3vbgR/8VDkKsgceoMQFQpTBdDrdaU7Ix0pVzNoL1MeQOtmi+a+PQDJi0Ca3XF8q
         ppxU8XvnRPEihqkwhUIRDYfy+jTu7hrjHD9X1de+Qzmtkd5ulyDu9AS5/7YCXO0ra7/E
         Q0myErxYccGUCiRDFhCDFK2M+hsYT5qUpMBx/jFLE9KlXcij37RNBBsz+dTt16lB4gsI
         jVffezsPbNvK++8pGGKoN/Z221V1Ao2pbdLY6VC+WFJrj4wsxbx6KEr7nfJBrxj/wGHQ
         BblWoKp/04rWMM8Aik1GIgXD8oarLZMnU4h8JYlmqp1QixKO0k3CVpxpPi2trsNVpAoU
         vA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766426247; x=1767031047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wBha3d01qjiMew7UlnJKYluL6OwpP6oM7rEy/5DQKRo=;
        b=UXOj3NNuH30NA3XSGlcmRIG9c3dZvEW/jEKzpJJ/M1fZITrwlSCwuw+HuzYIvo3HkG
         fSVBTNf7S7f3+I6DZGzpz5D9zXEH2VJPI30rdthx7Csp6Q9BPYg/W9jGm5m0IusxOTvr
         UyKld9R1Ipmm1cDMdUyCfe7dDdpHeZeWi5x3DjKtayGhZdoRShws+nQ+mib0eBpoDcZW
         6aRW4xZJ5KOnnI55TWX1mP9hilkkK+yZD1hT/NpZXJ+REsGZzgcBJ4gW3qLpiwWxDrLP
         l/BnU3srZUXx/J/9ceQ3vwZcSFzTs0MDBEfDXeJc1EHzFiuFRg1vMOrmrKMeCsR8e7V8
         B81A==
X-Forwarded-Encrypted: i=1; AJvYcCVB50HtaVyrOwm8yH0LxHGYSW4Kn1iBJ9S+46q55IcW+93PMpL+z4QeCihWmCLrwTserltP8b+UU40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLfY3j13Cw2tzFC0ufy2cyGiUYBCL/B9y5t5355CvD1W2j6/kY
	LyHc0EckqgwEUETPDR82qsvTy5I3Ta/MexQeZUZc+SNQg5ix0n6xS45GfkpE+O22+YR+VXzKPfL
	r4ayjKUWbq2v+ms7TGvVz71jqzpj/T0Y=
X-Gm-Gg: AY/fxX4EAKvCiePgC52YNn/mJrq7Q2FtQWJBXJQbGxQSbvGOY2YubMueZWMqPAFNt+0
	lhPOjVk+aGm/9kObZbUHx9kuZmLxT5pL/fhd7fCF1QEgNxhUXvG/1b4AdP0s1XEGja2Gu6kCCzq
	wpu5sfy+J2eYxuS1HazPabalCc8Sya76BAXe9nquf/3bCQKbosHBLefc+HZXBYTHpOCB71CMSSL
	wTof9bJfvEKEM2+Be535i+bcNcGZvFvwQqSoGM4OKnOiM86BaUBWF2ATi/NUYJer2O3ltQ1gzNR
	xGeG
X-Google-Smtp-Source: AGHT+IHGjnM4tssmgrpgdS+QyfppBwGcEa/TtaSTVo3x3z2X4MIp6+nQ00I9y9UQh1U0WtN9dG4OQo1+7sN+Qmf+nvg=
X-Received: by 2002:a17:907:3f25:b0:b80:117d:46e5 with SMTP id
 a640c23a62f3a-b8036f62257mr1197264466b.29.1766426246688; Mon, 22 Dec 2025
 09:57:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOprWotBRv_cvD3GCSe7N2tiLooZBoDisSwbu+VBAmt_2izvwQ@mail.gmail.com>
 <CAA7ZjpY-q6pynoDpo6OwW80zd7rq3dfFjQ1RMGzJR4pKSu7Zzg@mail.gmail.com>
In-Reply-To: <CAA7ZjpY-q6pynoDpo6OwW80zd7rq3dfFjQ1RMGzJR4pKSu7Zzg@mail.gmail.com>
From: Andrea Daoud <andreadaoud6@gmail.com>
Date: Tue, 23 Dec 2025 01:57:15 +0800
X-Gm-Features: AQt7F2pbRWy0Y3qdReSvX4Mn03sO7NEaq-NkFe6B_tFRTn8ukhodMW_kVgnL2-o
Message-ID: <CAOprWov+j6V8XmtQD-K6pBj+7CVP_QJM0ODbJxtPZqG=y2RW3w@mail.gmail.com>
Subject: Re: ctucanfd: possible coding error in ctucan_set_secondary_sample_point
 causing SSP not enabled
To: Ondrej Ille <ondrej.ille@gmail.com>
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, 
	Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your reply!

On Mon, Dec 22, 2025 at 11:51=E2=80=AFPM Ondrej Ille <ondrej.ille@gmail.com=
> wrote:
>
> Hello Andrea,
>
> yes, your thinking is correct, there is a bug there.
>
> This was pointed to by another user right in the CTU CAN FD repository wh=
ere the Linux driver also lives:
> https://github.com/Blebowski/CTU-CAN-FD/pull/2
>
> It is as you say, it should be:
>
> -- ssp_cfg |=3D FIELD_PREP(REG_TRV_DELAY_SSP_SRC, 0x1);
> ++ ssp_cfg |=3D FIELD_PREP(REG_TRV_DELAY_SSP_SRC, 0x0);
>
> Unfortunately, we have not processed this in the CTU CAN FD repo either.
> I can send it as a patch, but TBH, I have never done this before (the dri=
ver was contributed to Kernel by Pavel Pisa, he is the maintainer).
> If you point me in the right direction to the steps I should follow, I wi=
ll be glad to do so.
>
> With Regards
> Ondrej Ille
>
> PS: The changes are dummy enough that they will likely not cause a large =
review, so it seems like an ideal case for trying to contribute for the fir=
st time.

Unfortunately I do not have an environment right now to make patches
sent, so it would be better if someone else can send the patch.

> PPS: I will go on and fix it in CTU CAN FD repo too. However, ATM I don't=
 have a setup where to really test this.

I have tested it on my setup. I run this core on a FPGA, with PCIe
connected to Linux host. After changing this to zero, I can see the
relative phase of sample_sec has changed to a more ideal phase in the
received bit.

>
> On Mon, Dec 22, 2025 at 3:17=E2=80=AFPM Andrea Daoud <andreadaoud6@gmail.=
com> wrote:
>>
>> Hi,
>>
>> In ctucan_set_secondary_sample_point(), there's a line which runs when
>> data bitrate is >1Mbps:
>>
>> ssp_cfg |=3D FIELD_PREP(REG_TRV_DELAY_SSP_SRC, 0x1);
>>
>> In the datasheet [1] of ctucanfd, we can see the meaning of SSP_SRC:
>>
>> SSP_SRC: Source of Secondary sampling point.
>> 0b00 - SSP_SRC_MEAS_N_OFFSET - SSP position =3D TRV_DELAY (Measured
>> Transmitter delay) + SSP_OFFSET.
>> 0b01 - SSP_SRC_NO_SSP - SSP is not used. Transmitter uses regular
>> Sampling Point during data bit rate.
>> 0b10 - SSP_SRC_OFFSET - SSP position =3D SSP_OFFSET. Measured
>> Transmitter delay value is ignored.
>>
>> Therefore, setting it to 1 disables SSP (NO_SSP). We should probably
>> set it to 0 (MEAS_N_OFFSET).
>>
>> Is this correct? Would like to hear some inputs.
>>
>> Regards,
>>
>> Andrea
>>
>> [1]: https://canbus.pages.fel.cvut.cz/ctucanfd_ip_core/doc/Datasheet.pdf

