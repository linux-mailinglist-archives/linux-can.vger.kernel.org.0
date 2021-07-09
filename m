Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74343C2355
	for <lists+linux-can@lfdr.de>; Fri,  9 Jul 2021 14:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhGIMUe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Fri, 9 Jul 2021 08:20:34 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:43898 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhGIMUd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Jul 2021 08:20:33 -0400
Received: by mail-lj1-f175.google.com with SMTP id r20so7707057ljd.10
        for <linux-can@vger.kernel.org>; Fri, 09 Jul 2021 05:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YZm+mB3sNKOGEFxF/5UZmvWEsYL4tV/B5Aff2aVFURs=;
        b=f3vPmYoMyPa1n6mvakTklmDYA61p9dNaUgnWuiBHZq0Knw7VMz+baO6BmT0KCRTQix
         lMDmoBJi37PkcFTgSDh7T9EtAKV9EJWFATyaVbP3ASoZ7qMbNfg4MHxPopjWx9xQjHFE
         GY0weo2sR5ySRcMEIw3aMG8krfL1Lri0HniOmgsShnRM7mzHlHV1hdOg0ACIP/z/6I7E
         CDvRqSFdT2+JDaSITcm6YfvOsNM0T0U8RJbZFoj9NHw/KCTqVW8Eqce/wSk5JFOu67Cl
         eQMWy+L1W9FIQM2QIrF6sS2WSkN5Gif+6tNJh2UxIPgjJgMX+yEB+cc9MXFSVe80Xlmg
         ISHw==
X-Gm-Message-State: AOAM531zsLfmeEVDkJJaYcwGlK7zRZVB1UKSkwGkTyxo697vq3Mh+Rc2
        /hW0dtKCO4F7GkTROp4wALgCqG/ojcdzbgwTyMgtLnbtPuy0/VmlxFsT3A==
X-Google-Smtp-Source: ABdhPJzEA32mARWZd0UfV8QkPhADd0o0pkGUDEDho8azWB8DOH0FXdbM30I0h7Y6MqltvLxpMv2B092dAzz0KmOmRsY=
X-Received: by 2002:a2e:5c41:: with SMTP id q62mr28590418ljb.254.1625833069558;
 Fri, 09 Jul 2021 05:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210628154402.1176099-1-mailhol.vincent@wanadoo.fr>
 <20210628154402.1176099-4-mailhol.vincent@wanadoo.fr> <0f23c1e5e4bcfcc7d8077c859788031b0e7214b4.camel@esd.eu>
In-Reply-To: <0f23c1e5e4bcfcc7d8077c859788031b0e7214b4.camel@esd.eu>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 9 Jul 2021 14:17:37 +0200
Message-ID: <CAMZ6RqKyL81CK_U9K-NZ4sNCLt8bKVWZ8mhcPd=p=cVHMO5RjQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/4] iplink_can: print brp and dbrp bittiming variables
To:     =?UTF-8?Q?Stefan_M=C3=A4tje?= <Stefan.Maetje@esd.eu>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed. 7 Jul 2021 at 18:33, Stefan Mätje <Stefan.Maetje@esd.eu> wrote:
> Am Dienstag, den 29.06.2021, 00:44 +0900 schrieb Vincent Mailhol:
> > Report the value of the bit-rate prescaler (brp) for both the nominal
> > and the data bittiming.
> >
> > Currently, only the constant brp values (brp_{min,max,inc}) are being
> > reported. Also, brp is the only member of struct can_bittiming not
> > being reported.
> >
> > Although brp is not used as an input for bittiming calculation, it
> > makes sense to output it.
> >
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>
> I think it is a good idea to display both brp and dbrp values because it makes
> the displayed bitrate settings complete. Even if it could be calculated from the
> displayed clock and tq values.

Your remark is true. I also realized that BRP can be calculated
from the other parameters but because I am lazy, I like to have
it reported so I wrote this patch. I will add a note in the patch
comments to reflect that this value could be calculated by hand.


Yours sincerely,
Vincent
