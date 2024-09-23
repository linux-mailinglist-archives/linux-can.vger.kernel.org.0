Return-Path: <linux-can+bounces-1527-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 830E697E5DB
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 08:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C89B1F2169A
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 06:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4745C17591;
	Mon, 23 Sep 2024 06:07:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC1717C79
	for <linux-can@vger.kernel.org>; Mon, 23 Sep 2024 06:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727071676; cv=none; b=QERRPZ2Q/7qcXjC+SK9EZYm78bIC+IFelssbDRTHdujDw+vscUKO/kHj+Y5LOUpKkB6h0XKITlIi8OW0nZpt0wxj5T3DKnSX0o94arAQ0foku26rG4qPvO2w1Ljadr8TB/4ltyKmXxDWJmvMLu8gAI7abuDv3ewv1jGkx2tJtUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727071676; c=relaxed/simple;
	bh=ivEfNAOyW+90srU3esfS2lt/T58vedyrg3ETzSwA8lE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ib0icfo11WsLpk0eLsMAvTx/HwyAX5yJaIS2U+hP54lLSslY2JoQ+kJPlajF+6ZzT2XCppA0U649Up8sST3RLW8ai827dmHStpSd9FsNU4lO2T1IOMOuDUV5cbKKcVFRJ9iAEJ87oJCS7MrGOgbicHldFi+Xgrc2UNSBxpi4kzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71798a15ce5so3415499b3a.0
        for <linux-can@vger.kernel.org>; Sun, 22 Sep 2024 23:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727071674; x=1727676474;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7kfkF+GdDJpEQQH9BeZeJd8aAmi1ICJAxsqo7PcqdY=;
        b=fYoEMoH00XAB3ube0YG1WZjf/+XqyP+unXWvpddbVBsxHXfbtcd96IhfOA9EszI/Q6
         pW3wNyJodRUX2+krNSgxkZLYTvKahCz1s9+SQBBsEgrPGwEdY4dSLRzMxHqmkMwQpQS+
         KU8aP23sLQuAO5P9iehqulSDYbZMAmMi3c0rYrXDqGEWZ/rCyIdoQLfnwGpcygLOx8mM
         R9EU32jNXE+KhwGVXhxaegKKh8Migr00C0WseZ2GTLlvMHQtboY5JqqQzI2JJHUB0b6V
         PuxkA9JttD9Zm/IAWPQaALGD9/JeiNJsV3kB012gOSTrfyhUg3zHDfGOcblAv1mT2pEg
         hSwg==
X-Gm-Message-State: AOJu0Yx8K+TA4RkJptGogFxhkitweoiQY29IvGUssB1UGyntEcukk6pi
	DmJYdf7yaVuFTz/XDgQDk66sR3d7SNgaaecrp+suMW8Vh2C+eSUQTAVifZRyM1tKiw+soOmkrtl
	EzlVNioUA6IDnO9qlEbhi/73liBDbWZYWEJo=
X-Google-Smtp-Source: AGHT+IH5Tmed/P8DsvNK7BwH3wVZY5wDWPOkrHQw+kNBXtfejCF2TWVlXriaP7baOYYLK5wBjegvZ1wcFsG5C/etWpU=
X-Received: by 2002:a05:6a20:e687:b0:1c0:f114:100c with SMTP id
 adf61e73a8af0-1d30a9ab6f5mr16485980637.17.1727071673794; Sun, 22 Sep 2024
 23:07:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913185156.123924-1-ak.alexander.kozhinov@gmail.com> <CAMZ6RqLCqMTVSwi2Qbqje7LrO5z5deCHBkdqJhPYTaHUYdOnMw@mail.gmail.com>
In-Reply-To: <CAMZ6RqLCqMTVSwi2Qbqje7LrO5z5deCHBkdqJhPYTaHUYdOnMw@mail.gmail.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Mon, 23 Sep 2024 15:07:42 +0900
Message-ID: <CAMZ6RqLkv1x_B8KcyRw0pRxMxKnL2O32Sc8jzwC=BZyf1gxhCw@mail.gmail.com>
Subject: Re: [PATCH v2] can: gs_usb.c: add usb endpoint address detection at
 driver probe step
To: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maximilian Schneider <max@schneidersoft.net>
Content-Type: text/plain; charset="UTF-8"

On Mon. 23 Sep. 2024 at 13:00, Vincent MAILHOL
<mailhol.vincent@wanadoo.fr> wrote:

(...)

> > +       if (rc) {
> > +               dev_err(&intf->dev, "Required endpoints not found\n");
> > +               return rc;
> > +       }
> >
> >         /* send host config */
> >         rc = usb_control_msg_send(udev, 0,
> > @@ -1466,6 +1478,10 @@ static int gs_usb_probe(struct usb_interface *intf,
> >         usb_set_intfdata(intf, parent);
> >         parent->udev = udev;
>
> Maybe have the usb_find_common_endpoints() next to this? There is no
> need to do the endpoint search earlier, so better to group this which
> are related together.

Actually, if you move the usb_find_common_endpoints() down as I
suggested, you would have to add some clean-ups (e.g. kfree(parent))
if the function fails. Probably not worth the effort. Please ignore
this last comment.

> > +       /* store the detected endpoints */
> > +       parent->ep_in = ep_in->bEndpointAddress;
> > +       parent->ep_out = ep_out->bEndpointAddress;
> > +
> >         for (i = 0; i < icount; i++) {
> >                 unsigned int hf_size_rx = 0;

