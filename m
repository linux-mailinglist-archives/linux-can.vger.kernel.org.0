Return-Path: <linux-can+bounces-3590-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB56ABD01C
	for <lists+linux-can@lfdr.de>; Tue, 20 May 2025 09:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF07F3B0F19
	for <lists+linux-can@lfdr.de>; Tue, 20 May 2025 07:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5D325CC63;
	Tue, 20 May 2025 07:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ivhpsD2e"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C91D25CC5E
	for <linux-can@vger.kernel.org>; Tue, 20 May 2025 07:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747725273; cv=none; b=P1UbIEZ5QgvIbw94KkVuziAW0e6kemODaABcwxlQetL/bnKX8JH+sqOpzkXqXSQxyoiEm+6H22lBNKKGctCeUgEnu2Fn/oQnhyq2Cbjqsl/G6VcC3a0irlXRQEpS5dshgZH8jiu0mGWAsIizX8vMJH/lOAzTwGsN6o3fqNPzVoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747725273; c=relaxed/simple;
	bh=tRidWgdVXaGgcCCS4EcX/PPe0mHajjfMB8wA86WKrx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CvVEvjZHByWQnEU0FAhp3twjMpkkU1yGoiOjqoD4lokklXAKod1lv/PQn6ZkaqEA98iLcsQMLw4ekF/wZZwPDpbUIzxC9x4qfSgFMlvvRu4KP1Gt6fNIK0GPcThyMAdc8lN5BIr7I6ZM5Eixyt459xoRQsAjZ5K2Cm5T2jPQLpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=ivhpsD2e; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e733e25bfc7so4621853276.3
        for <linux-can@vger.kernel.org>; Tue, 20 May 2025 00:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1747725270; x=1748330070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2vQFMPdKfJ/p2joX4Ju/wpunrwcSJg3TjeoVymBJqk=;
        b=ivhpsD2ewi94M7LvQw25iKZxT4EJalTASPOZ0qcS13a4M7Z0+YDoLiGENVnB6aqAAB
         bfIinKiKDimBof2YSfxjs5dFWD+SDW8rGzRxetTKNe2tSgCGG4DRU1RmxyHzXDSmnOqm
         ECATzsiIpVZkq1m5TiDRVom7erV3ONDdBw26Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747725270; x=1748330070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2vQFMPdKfJ/p2joX4Ju/wpunrwcSJg3TjeoVymBJqk=;
        b=LK9SCv4Je2QF/GhVmau+whAOVjblS3lSc3QyHi6KJML+U/mrQf0BmsEokvxLKbfOPX
         KPhPhSuGzG21QF9CNPKbmCiEZUq7anlV2vDuAVS1xPtTnpWYJ4h3sH1nB50V+Mqik4rg
         FPYniU5Cgntv84alXqVm4xYmaLjxcOnrTpfYxXDNElOTJlMB12NSSbhKV02yphYxsaxp
         WzH7WqN8+Ab6ILqTY2ghInh6UbttmhRKBpkOKv7lJ/OBwgBwR7LFWqsH5m9hg5V5OGaX
         aP+wFzhAuGyI4DSqW5QfE9NmaMM8JrgMPEV0Dsc70TLdLaLKOkUQU+QuV6ORF0JeQigS
         D1+w==
X-Forwarded-Encrypted: i=1; AJvYcCU9AUziAANySLeXRi6zN/y1XlZh7VUOjO/sDN1Gd7amCP912dSW9EnZF1i81BoX6itgBRCcoDOrO6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXim2RjqfG0OZc9/+1WgL9PInoKVWxD40MGlaW+ebV7lP8vjj6
	iTxoi7bhLBnp07bFwhp2vDqdHyK8fFcLu9MXK58N/yOzfLZMSmVaiTLLIrUOrWxQd0NfFkZinno
	pQDUePL8w4keQeCB71fPFeo21wPsvy1HdPA8RwIYDAs0D1mVKqGHIUN0=
X-Gm-Gg: ASbGnct+zW5YJ300WxuqzTdpG8qe5+ZEFQqPhOKDsYr7MTDvzP+VS92jTTQsQ7w/7rT
	64vx1YKvFw0ZplRRDyPp/XNAtAFczi6t2kTw1rb24pCPYDRzF6rgq8vcpox4Pzxwf1kfe6kFVtW
	7penBgF0GVhupbtEhaJ43ShMIiH4ZGtQ==
X-Google-Smtp-Source: AGHT+IEM7b0OXs4NDSUR5+Bppi6SlwJi8oTGdYepNkoiw2G+oPZIJQUjqWLQPMfXSSqAksVKS15RtGrVmG8l92zD0WM=
X-Received: by 2002:a05:6902:2401:b0:e7a:b45a:c73d with SMTP id
 3f1490d57ef6-e7b6d414212mr19137181276.22.1747725269765; Tue, 20 May 2025
 00:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519163100.733754-1-carlossanchez@geotab.com>
In-Reply-To: <20250519163100.733754-1-carlossanchez@geotab.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Tue, 20 May 2025 09:14:19 +0200
X-Gm-Features: AX0GCFskUWIky5PJoNINmYxjzoP-_yCaaDhrZI9r_XLRufr_nROmRWwlkwB51CI
Message-ID: <CABGWkvpCQ-5wVp_TGRg2i7rtERwBykke_Y+ScCOXupiwtmAdjQ@mail.gmail.com>
Subject: Re: [PATCH v3] can: slcan: allow reception of short error messages
To: Carlos Sanchez <carlossanchez@geotab.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Carlos,

On Mon, May 19, 2025 at 6:31=E2=80=AFPM Carlos Sanchez <carlossanchez@geota=
b.com> wrote:
>
> Allows slcan to receive short messages (typically errors) from the serial
> interface.
>
> When error support was added to slcan protocol in
> b32ff4668544e1333b694fcc7812b2d7397b4d6a ("can: slcan: extend the protoco=
l
> with error info") the minimum valid message size changed from 5 (minimum
> standard can frame tIII0) to 3 ("e1a" is a valid protocol message, it is
> one of the examples given in the comments for slcan_bump_err() ), but the
> check for minimum message length prodicating all decoding was not adjuste=
d.
> This makes short error messages discarded and error frames not being
> generated.
>
> This patch changes the minimum length to the new minimum (3 characters,
> excluding terminator, is now a valid message).
>
> Signed-off-by: Carlos Sanchez <carlossanchez@geotab.com>
> Fixes: b32ff4668544 ("can: slcan: extend the protocol with error info")
> ---
>
> I have remove the unclear global min length check incoming serial
> line messages, and add a min size check per message type. While doing
> so, I have renamed SLCAN_STATE_FRAME_LEN by s/FRAME/MSG/, because
> those are serial line *messages* (and CAN frame is one of the possible
> types of messages). Using "frame" the old way was confusing, even more
> when adding the defines for other message types.
>
>
>  drivers/net/can/slcan/slcan-core.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/s=
lcan-core.c
> index 24c6622d36bd..bbb2f82a6147 100644
> --- a/drivers/net/can/slcan/slcan-core.c
> +++ b/drivers/net/can/slcan/slcan-core.c
> @@ -74,9 +74,14 @@ MODULE_AUTHOR("Dario Binacchi <dario.binacchi@amarulas=
olutions.com>");
>  #define SLCAN_STATE_LEN 1
>  #define SLCAN_STATE_BE_RXCNT_LEN 3
>  #define SLCAN_STATE_BE_TXCNT_LEN 3
> -#define SLCAN_STATE_FRAME_LEN       (1 + SLCAN_CMD_LEN + \
> -                                    SLCAN_STATE_BE_RXCNT_LEN + \
> -                                    SLCAN_STATE_BE_TXCNT_LEN)
> +#define SLCAN_STATE_MSG_LEN     (SLCAN_CMD_LEN +               \
> +                                 SLCAN_STATE_LEN +             \
> +                                 SLCAN_STATE_BE_RXCNT_LEN +    \
> +                                 SLCAN_STATE_BE_TXCNT_LEN)
> +#define SLCAN_ERROR_MSG_LEN_MIN (SLCAN_CMD_LEN + 2)

What do you think about introducing some macros to remove the number 2, in
order to make the code more readable?

Something like:
SLCAN_ERROR_LEN 1
SLCAN_ERROR_DATA_LEN_MIN 1
And add them to SLCAN_ERROR_MSG_LEN_MIN

> +#define SLCAN_FRAME_MSG_LEN_MIN (SLCAN_CMD_LEN +       \
> +                                 SLCAN_SFF_ID_LEN +    \
> +                                 1)
The same here, replace the 1 number with a macro.

Thanks and regards,
Dario

>  struct slcan {
>         struct can_priv         can;
>
> @@ -176,6 +181,9 @@ static void slcan_bump_frame(struct slcan *sl)
>         u32 tmpid;
>         char *cmd =3D sl->rbuff;
>
> +       if (sl->rcount < SLCAN_FRAME_MSG_LEN_MIN)
> +               return;
> +
>         skb =3D alloc_can_skb(sl->dev, &cf);
>         if (unlikely(!skb)) {
>                 sl->dev->stats.rx_dropped++;
> @@ -281,7 +289,7 @@ static void slcan_bump_state(struct slcan *sl)
>                 return;
>         }
>
> -       if (state =3D=3D sl->can.state || sl->rcount < SLCAN_STATE_FRAME_=
LEN)
> +       if (state =3D=3D sl->can.state || sl->rcount !=3D SLCAN_STATE_MSG=
_LEN)
>                 return;
>
>         cmd +=3D SLCAN_STATE_BE_RXCNT_LEN + SLCAN_CMD_LEN + 1;
> @@ -328,6 +336,9 @@ static void slcan_bump_err(struct slcan *sl)
>         bool rx_errors =3D false, tx_errors =3D false, rx_over_errors =3D=
 false;
>         int i, len;
>
> +       if (sl->rcount < SLCAN_ERROR_MSG_LEN_MIN)
> +               return;
> +
>         /* get len from sanitized ASCII value */
>         len =3D cmd[1];
>         if (len >=3D '0' && len < '9')
> @@ -456,8 +467,7 @@ static void slcan_bump(struct slcan *sl)
>  static void slcan_unesc(struct slcan *sl, unsigned char s)
>  {
>         if ((s =3D=3D '\r') || (s =3D=3D '\a')) { /* CR or BEL ends the p=
du */
> -               if (!test_and_clear_bit(SLF_ERROR, &sl->flags) &&
> -                   sl->rcount > 4)
> +               if (!test_and_clear_bit(SLF_ERROR, &sl->flags))
>                         slcan_bump(sl);
>
>                 sl->rcount =3D 0;
> --
> 2.49.0
>


--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

