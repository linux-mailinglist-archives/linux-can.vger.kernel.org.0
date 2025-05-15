Return-Path: <linux-can+bounces-3575-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE43EAB7DAC
	for <lists+linux-can@lfdr.de>; Thu, 15 May 2025 08:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E468C22E0
	for <lists+linux-can@lfdr.de>; Thu, 15 May 2025 06:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BFB296D33;
	Thu, 15 May 2025 06:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="WZMKWJOn"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-72.smtpout.orange.fr [193.252.22.72])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B86286D73
	for <linux-can@vger.kernel.org>; Thu, 15 May 2025 06:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747289870; cv=none; b=oO/Qzpk3nNVDHDBfg731ZW74p5FySxSc3IQTQpoIM0kBuwPVdXvAL4AryXziqgXXxkz7fj6mF1Y+NNqoOTERvtb1A0LPcho9FPlRwuV56USxovgjJbVPaQua4qp1x4RGgjtwJ3/oCcaeWpmVE1UCQ/nWz08iYpFcnrPPfLxtpHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747289870; c=relaxed/simple;
	bh=kdFTYORzW9ThiHY8nWPHpIN1MsCq1PcqDQZtBHv+rFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXZuLwNd6C9GBNEu7uJl6LTiaD/4BSTly4NlwXHx4+Y9el3UYYtR+hjYO1tgslV7Zy123zy5dXWX3iGCOL7LB10XUOrkwkJ/93HJA+4DtpW2qUaxYnvExCKv7gr/qiUIN1eIx8BtLxF+BgOhQBVQmbWsyrEs5jG30bgHLWZK7lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=WZMKWJOn; arc=none smtp.client-ip=193.252.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ej1-f46.google.com ([209.85.218.46])
	by smtp.orange.fr with ESMTPA
	id FRtSuAdiKL24dFRtSuWAxC; Thu, 15 May 2025 08:16:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1747289794;
	bh=fzfU9enUJH8TTn5bqWtQrubZ+4qpsGroDYWZgIy2AA4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=WZMKWJOnWEFxZ7ni6GaT1lcCDJv7roKg9Z9bkHXoaPBgo+XfbsumPh5klZpkswyYi
	 MNnoI4IPC4dQIreIzgboNlS9GRefT30zmxTLumPVuLETVdBif4wfk4aZDF/0aDzQn1
	 X92SRyI8pTLf9KOpLgWS0NW1dMaWpvyo+kA3Cyn96ceA9bYXndkeR0/SBl5vJOyaei
	 hc8V2DaXWOo824dbg7EprjAfgAhX15jteGUmxIzBMtNOalPVpPDRG1bildPEK7NIlB
	 b5qO5mUqryuBRiFWn3cQNeXi4MepiEqm9POAnT6QyccuglG8nqMQahugx+4OS//IpO
	 L0fdVeYwZGIQA==
X-ME-Helo: mail-ej1-f46.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 15 May 2025 08:16:34 +0200
X-ME-IP: 209.85.218.46
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad1a87d93f7so88850666b.0
        for <linux-can@vger.kernel.org>; Wed, 14 May 2025 23:16:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXBZ/w8x4vVgziuAM4KUmZDLAOC/EGhWaOC/9UcBt+bfpgjGx03LZr3Qny79SBQPlv1Oy7OhVH0esE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws0mwOYagzHLxIiCYkEagZQf9e4bVuJ2F23Y1lvKy3/rLgmKl/
	pJ6f6ZgGinA7SOBsHEtbiFrcx1BcUNuBLbh7o2ySCH7uQQAp/5A7ybwCE3xqiNUgpkTFAyVxMVK
	HOMh1y54ypHpzmVbU8JzUDICdr/Q=
X-Google-Smtp-Source: AGHT+IGFyqRU86acSRrFTv+ilcJT6XRJuiXlhiAdABY/xxdvlnzGcdCp/ybt5KJAuSeTJB5eeFea/5c2kYDVSfwz8xw=
X-Received: by 2002:a17:907:c012:b0:ace:8398:b772 with SMTP id
 a640c23a62f3a-ad515dd712cmr99249966b.14.1747289794114; Wed, 14 May 2025
 23:16:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514092957.1068570-1-carlossanchez@geotab.com>
 <CAMZ6RqLLv1WoMdBjkJ77y0kj0Wg2LLO6Bx+1qCUJSGeyuJkTbg@mail.gmail.com> <CAEQW48K97NANQD9fha4P6esY92Ma=7FXRs+_btb5Jd6w4WkoNQ@mail.gmail.com>
In-Reply-To: <CAEQW48K97NANQD9fha4P6esY92Ma=7FXRs+_btb5Jd6w4WkoNQ@mail.gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Thu, 15 May 2025 15:16:21 +0900
X-Gmail-Original-Message-ID: <CAMZ6Rq+Qq7Xsn3iggkSjdL0YPFzgevujT5q4_c4YYW2MRCTwpA@mail.gmail.com>
X-Gm-Features: AX0GCFvLQgt3RpXBh3TO3jMuFdwAdvQ7cpWh1wrqsnZhVyrv_LVrbn4e7LKXk_s
Message-ID: <CAMZ6Rq+Qq7Xsn3iggkSjdL0YPFzgevujT5q4_c4YYW2MRCTwpA@mail.gmail.com>
Subject: Re: [PATCH v2] can: slcan: allow reception of short error messages
To: Carlos Sanchez <carlossanchez@geotab.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
	linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

[Resend] I inadvertently only replied to Carlos. Resending with
everyone in CC. I am just resending the very last message, please
refer to the quoted text for the past exchanges.

On Wed. 14 May 2025 at 19:43, Carlos Sanchez <carlossanchez@geotab.com> wrote:
> Hi Vincent,
>
> Thanks for reviewing.
>
> > >         if ((s == '\r') || (s == '\a')) { /* CR or BEL ends the pdu */
> > >                 if (!test_and_clear_bit(SLF_ERROR, &sl->flags) &&
> > > -                   sl->rcount > 4)
> > > +                   sl->rcount >= 3)
> >                                     ^
> > Nitpick: maybe it would be better to replace the litteral 3 by a macro?
> >
> > What is the definition of a slcan short message? Is it a message with
> > just a SFF ID?
>
> These messages do not represent real CAN frames, but error messages
> coming from the adapter (which are translated by this driver on error message
> CAN frames, which is the SocketCAN way to send low-level errors to the
> application). So the "shortest possible" message has nothing to do with the ID,
> it just happens to be 3 because "e1X" (where X is an error code) is a valid
> message.

Ack.

> Defining a macros is a possible idea. I could do:
> #define SLCAN_MIN_FRAME_LEN 4 /* Min. length of a tT/rR frame */
> #define SLCAN_MIN_ERROR_LEN 3 /* Min. length of an error message. */
>
> And make this check against the minimum of all the message lengths
> (including SLCAN_STATE_FRAME_LEN which is already existing in the code).
> If you want the advantages of the macro, it needs to be done that way because
> different message types have different minimum lengths, and assuming error
> messages are always going to be the smaller ones kind of removes the value
> of having macros for the different lengths. Runtime checking is not problematic
> (compiler will simplify it because it knows the value of the
> boundaries at build time)
> but the code would be slightly more confusing.
>
> Another option is removing this check altogether, and adding size
> checking in each
> message-type-specific processing function (slcan_bump_xxx() ), which
> is partially
> there already.
>
> The second option would yield simpler code so that is a better option
> IMHO, but it
> will make the patch slightly bigger.

I also agree that your second option looks cleaner.

I do not mind if the patch gets bigger if at the end the result is
some code easier to understand and to maintain :)


Yours sincerely,
Vincent Mailhol

