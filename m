Return-Path: <linux-can+bounces-1713-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B0C9A0F5A
	for <lists+linux-can@lfdr.de>; Wed, 16 Oct 2024 18:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11DD2815AB
	for <lists+linux-can@lfdr.de>; Wed, 16 Oct 2024 16:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5024120F5BF;
	Wed, 16 Oct 2024 16:09:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8418720F5B0;
	Wed, 16 Oct 2024 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729094974; cv=none; b=m7LEjik0YK6vJVTWLC7gdggjTe41G3PARlzjlE5nZBp5Ek8SXR1QSQktvb9JvjpKYCFN74piIPcymOy7RmJ09MiygUmZ+lMCach7AF9bbodFZXl+6N63TW7+byXzgtL3La4QYkwmtA5uaeui58SlOx0sbT/lIizQlEsnYVOVfzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729094974; c=relaxed/simple;
	bh=vSsZqDJWpQ20mq3tHE0Fb47pANLlhNT0u6UPTtuQgeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DvD9Zz9FUYurKlthPzGGAOJT3xcymrWLyi8otLmb+zAotPMvX6v7CXvzb4MRqVc5LqLVKFQ/Cf2j492ug0Y3bym2NOkTV3J4BxYPk3E91AvG/DjMZqOrh+Z/HrAcSQ3sRxqGGNaAk8l6sMId/eJ3KGeLZGUd3/+BDaAtQvdtN+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a99ebb390a5so211609766b.1;
        Wed, 16 Oct 2024 09:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729094971; x=1729699771;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OmTlR+mvqJAz1EmxrOCGVHDAWntliLwxpGc0qQgNhZ0=;
        b=BKBgrMchnzIJR1QsHT5xqQm5vRmEKHqjlmjUdJUAWlRG5ENXRThrVZW1d0Y6H4qntH
         OvsWH8Wm53XzS0auV83d/133kAl+1zSeynUW7KMZwNoPD6Ufa94pFwzSAd+tTIhMefUn
         2YNCcnhVyPZhZcLqPkSxKkE45ISSnMZLEMRX5ozkM00rARajENkZLhCnFOZIoESDepCa
         G3WHTecQFcOKbDnbx3lGpWqr+pZeC1t1bBuQCJEnRrWdK1UN6//U9Vg8zyfieGBuAMb2
         wcNu1YD/0NjgMUQRAaMJ8R8fS/JPwXKDs7wroW2kuwfI0wHptCT/IXAgpMl1llKAAXrQ
         pyrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA/itMSQK3YLZHA7B/A1ouFG8upDJW7BZ8w7UgqSYitzHQazbyFJpnGOo6/gydHc0KMJRlKQZIN7vA@vger.kernel.org, AJvYcCWFYJUkMuw/gW3mlm7DpCw2QuKCSXsaD1X8et8AZZsssiVSSUhUZbNPn23miiv0DjKvZ5uyBFPgZX8COUvn@vger.kernel.org, AJvYcCWuURtGMF2+NNwKLujAi/9rJHJrKzfR1HehZ3SobMY9OnXmvDMg2rRI7JL7XKcrPybuFwgB26eXVf0l@vger.kernel.org, AJvYcCXUmbaom7v6kqmvhAyq3etLSTokpsNcty1kj8M4nZWAwpRhQwrtrgm6+TSNgaEW8suYbKoJxo53@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrd3LFHHoElTHUxuRk2+s9MjvUnJaB5lSpnGfS1Vf9KkjxGX53
	9qB2CqgKYq/vBK2BG1Q8iLI/sSF1x1XAYOE4ohYGzWFhmNG0gx07v3qBHPBQ5slDPkeFaF8EI4n
	8+VByvHfhMGZLWzqXMRHYtfPUH40=
X-Google-Smtp-Source: AGHT+IE59HHi6RfvNl0jd60GRp+Q4oTDVjpD1WxXKT5MU1/v8dV6ZpMG9trRhhhjywvzxGohJIOt3dIwrEjC1SoM+b8=
X-Received: by 2002:a17:906:7308:b0:a9a:3df1:436a with SMTP id
 a640c23a62f3a-a9a4c2f3ce7mr14608566b.8.1729094970681; Wed, 16 Oct 2024
 09:09:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015-topic-mcan-wakeup-source-v6-12-v4-0-fdac1d1e7aa6@baylibre.com>
 <20241015-topic-mcan-wakeup-source-v6-12-v4-5-fdac1d1e7aa6@baylibre.com>
 <CAMZ6Rq+NA9G=iON56vQcr5dxEMqn-FFzT5rdxc6XrtW+4ww1XQ@mail.gmail.com> <xiptvia2w5ocs7td2zgn3pueok2nzdslf7og4ekg3o6hdxus7r@quz2v54zmhyz>
In-Reply-To: <xiptvia2w5ocs7td2zgn3pueok2nzdslf7og4ekg3o6hdxus7r@quz2v54zmhyz>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Thu, 17 Oct 2024 01:09:19 +0900
Message-ID: <CAMZ6Rq+sWB_SV0gt6K8n0cw+PjoN_fifCUJXTxJ7Hp8FEAt7-w@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] can: m_can: Support pinctrl wakeup state
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, Vishal Mahaveer <vishalm@ti.com>, 
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu. 17 Oct. 2024 at 00:42, Markus Schneider-Pargmann
<msp@baylibre.com> wrote:
> Hi Vincent,
>
> On Wed, Oct 16, 2024 at 11:26:22PM GMT, Vincent MAILHOL wrote:
> > Hi Markus,
> >
> > This is a nice improvement from the v3.
> >
> > On Wed. 16 Oct. 2024 at 04:19, Markus Schneider-Pargmann
> > <msp@baylibre.com> wrote:
> > > am62 requires a wakeup flag being set in pinctrl when mcan pins acts as
> > > a wakeup source. Add support to select the wakeup state if WOL is
> > > enabled.
> > >
> > > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

(...)

> > > +       class_dev->pinctrl_state_default =
> > > +               pinctrl_lookup_state(class_dev->pinctrl, "default");
> > > +       if (IS_ERR(class_dev->pinctrl_state_default)) {
> > > +               ret = PTR_ERR(class_dev->pinctrl_state_default);
> >
> > Sorry if this is a silly question, but why aren't you doing the:
> >
> >                   class_dev->pinctrl_state_default = NULL;
> >
> >                   if (ret == -ENODEV)
> >                           return 0;
> >
> > thing the same way you are doing it for the pinctrl and the
> > pinctrl_state_wakeup?
>
> There are no silly questions.
> The idea is that if the wakeup pinctrl state was already found, then the
> default pinctrl state is required and not optional, so no check for
> -ENODEV. Otherwise it doesn't make sense with the current binding or the
> implementation of the driver.

ACK. With this:

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

This concludes my review of your series. I am skipping the dt-bindings
and the dts parts because I am not knowledgeable in those domains.


Yours sincerely,
Vincent Mailhol

