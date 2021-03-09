Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25833325AC
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 13:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhCIMqK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 07:46:10 -0500
Received: from mail-yb1-f170.google.com ([209.85.219.170]:40655 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhCIMqK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 07:46:10 -0500
Received: by mail-yb1-f170.google.com with SMTP id c131so13789665ybf.7
        for <linux-can@vger.kernel.org>; Tue, 09 Mar 2021 04:46:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iZVX4P6GO6TuP6ukYs5oXp8i0aZ0okK0rj5UnJMGUJk=;
        b=DhDBdejYugNkM5J8bGDTt2ZjPeOAijOF90zV9iuxmoLHp35rJG0Qyz19CUA7qV/zNt
         jk/JWG4V2hYRypiDovpawjmyBg+OKokfMXE+4JSQUQ8fMkCso6kySGm5VVr9KMhzKJgX
         NRkLSIedrCNolNNV6SBp9YbtsBQzGmCSruyBxakb5qnvm/w4X5WoFNPHkk0Lv5T5aoP7
         FqW40b8OvWR+16uqzRrZgtatw0zs8IXViPxJ+PXKpYX+yLQVCM3v6Pz2WT2NFkrZ40TI
         IBEBJykOy6jAGiZOF9qYFC27g2TPWZs/96L+Z1J7PW77Yld8QTAaZM5xbZiMLCtFCZwf
         eXkw==
X-Gm-Message-State: AOAM5305xFa+iC0Rbqzqum6Tctm20cqxmDzs47OQNJhSggwdRdcapxva
        oR9uHh184q4VzrfoDum/TtlmdbjdTFsRLI9CWAQ=
X-Google-Smtp-Source: ABdhPJy8/qDhYu3gU+JR48ivgMQjBbZQrZ/gFyoNMXCJkth+72SVb6mOd0rtM8ir54uclHdDEH8W+7asJmM5dzzH0no=
X-Received: by 2002:a25:254a:: with SMTP id l71mr39837035ybl.125.1615293969483;
 Tue, 09 Mar 2021 04:46:09 -0800 (PST)
MIME-Version: 1.0
References: <20210308163445.103636-1-mailhol.vincent@wanadoo.fr>
 <20210308163445.103636-2-mailhol.vincent@wanadoo.fr> <2b43e72b-c561-d144-c01e-c4ea361cc932@pengutronix.de>
In-Reply-To: <2b43e72b-c561-d144-c01e-c4ea361cc932@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 9 Mar 2021 21:45:58 +0900
Message-ID: <CAMZ6RqJADCFL_=uv-=hNjiNj+CZkUDNWjLTP3eV010KGj+H49A@mail.gmail.com>
Subject: Re: [PATCH v12 1/1] can: usb: etas_es58X: add support for ETAS ES58X
 CAN USB interfaces
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Tue. 9 Mar 2021 at 19:27, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 3/8/21 5:34 PM, Vincent Mailhol wrote:
> > This driver supports the ES581.4, ES582.1 and ES584.1 interfaces from
> > ETAS GmbH (https://www.etas.com/en/products/es58x.php).
> >
> > Co-developed-by: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
> > Signed-off-by: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>
> I'm not sure if you're supposed to change dql.min_limit from the driver.

One thing for sure, I am the only one to do it.

The reason to do so is because benchmarks show me that values
below this threshold are not good for this device (and I try to
be very permissive on the values).

USB introduces a lot of latency and the small PDU of CAN does not
help. The BQL is here to remediate, however, the algorithms can
take time to adjust, especially if there are small bursts.
Modifying the dql.min_limit was the only solution I found to make
sure that packets can be sent in bulk even during small burst
events.

The BQL was not designed for USB nor was it designed for CAN
which probably explains why I am the first one to ever have
thought of using dql.min_limit like this. Using dql.min_limit is
a hack and I pledge guilty for it. However, because this hack
brings performance improvement, I would like to keep it if you do
not mind.


Yours sincerely,
Vincent
