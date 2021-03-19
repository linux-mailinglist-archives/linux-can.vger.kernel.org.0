Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED0C341E65
	for <lists+linux-can@lfdr.de>; Fri, 19 Mar 2021 14:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhCSNdV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Mar 2021 09:33:21 -0400
Received: from mail-yb1-f177.google.com ([209.85.219.177]:35863 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhCSNc5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Mar 2021 09:32:57 -0400
Received: by mail-yb1-f177.google.com with SMTP id b10so6280992ybn.3
        for <linux-can@vger.kernel.org>; Fri, 19 Mar 2021 06:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SCA00+ALAlQP/L9nJvyfPiP9C1I4BhZaOP0cUzQL53E=;
        b=Exopfo4mbjRfNwlryMTD7F0GtZE268pjc5sXlbP1NEpZu5ufjmswtpJOkXiJrQO/t6
         DahylI6RWsnOcyLGRZgId/TS51DSucDROXwuZmSoE2+xKzhV6OIqBuTbceAnXV2P+kaF
         f9HZ2OpeDAHDawFLC+aaZsrmnRI8nfAizHwfxg2ZtxwYqQsIA2FkrvZpNfE1UZuQdihF
         /ZszktfEJCrfX770+0QBzMOCMNql7s6BzrxylGZtjJjYsD6cxCNtVr1bNEsQOcV9M8oN
         jqX+YzACk0X4ncRF7Nv5zaY8bFuZHWIscsxRcbzPdfq254c4jFbBTFEuXotBrVuza5I/
         MT7g==
X-Gm-Message-State: AOAM530RhY2jUACk0A9sxVgJd7ZSAoiij5PHP70+AWn8OIx7CokdW7Jx
        WrnHNAUw9OtlsnpDlQB0V8tsVf/sBtnZvsaV5QOEd0xiTiKcnw==
X-Google-Smtp-Source: ABdhPJxYt82VLRWSDevPRUGodWfsRlNl6/nEo82vSO8TGULHUe69NFEs7dOGx3JOlbaWKsdXrrD4Uib+kd+Mtq8vEIw=
X-Received: by 2002:a25:73d1:: with SMTP id o200mr6768887ybc.239.1616160777103;
 Fri, 19 Mar 2021 06:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210319124141.247844-1-mkl@pengutronix.de>
In-Reply-To: <20210319124141.247844-1-mkl@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 19 Mar 2021 22:32:46 +0900
Message-ID: <CAMZ6RqJB_2c1MX8EaO+ZH+qgSjQDbq6PrsNJCJM=kw=hqxFMSw@mail.gmail.com>
Subject: Re: [PATCH v13 00/11] Introducing ETAS ES58X CAN USB interfaces
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri 19 mars 2021 at 21:41, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> Hello,
>
> this my attempt to split the driver into 3 patches, so that it can be
> send via mailing lists:
> - core support
> - es581_4
> - es58x_fd
>
> For now I've removed the setting of dql.min_limit, that can be added
> back in a later patch, once discussed with upstream netdev. While
> working on the code, I've added some typo and kernel doc fixes.
>
> I plan to squash the patches, I've kept them separate for better
> illustration.

Thanks a lot for your support! You could have asked me to split the patches :)

I was also myself working on a new version:
  - addressing the comments from Jimmy
  - following my exchange with Oliver yesterday, I realised that
    I totally misunderstood the meaning of CAN_CTRLMODE_LOOPBACK,
    I will remove it.

If fine with you, I can directly squash your suggestions while
preparing my v14 and just keep the 3 patches split as suggested.


Yours sincerely,
Vincent
