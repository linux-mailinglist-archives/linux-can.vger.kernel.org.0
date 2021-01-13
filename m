Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE982F423B
	for <lists+linux-can@lfdr.de>; Wed, 13 Jan 2021 04:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbhAMDEc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jan 2021 22:04:32 -0500
Received: from mail-yb1-f178.google.com ([209.85.219.178]:45135 "EHLO
        mail-yb1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728822AbhAMDEc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jan 2021 22:04:32 -0500
Received: by mail-yb1-f178.google.com with SMTP id k78so770141ybf.12
        for <linux-can@vger.kernel.org>; Tue, 12 Jan 2021 19:04:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UsKj12z3+N2Tn1TsNmzzJhwTvsE0oVzn2UigqYS9I1M=;
        b=MIgsUGln0eX8ObaLIILzYc8uFflMIhs27zMco38uu5PQrU3r4i5oa8hw6MQu00EQNP
         8iG3koB1PE7yKJtUmfIbCVFOC017tOMbzH1Eueyef32WJ7iSkbspE5yZu3SWqAJFNybb
         k6lwwICzya498u/E6MTBp94he905+Es53YmC7B4PPTt/unhFSXXq3fdQBs9X9q8U1s6x
         aKoF6ve7J7FQZoT+os6//jq75kgG0WHz/JXw/K7sWTtijV04qxs5kZQnH6qY09ly6wh7
         UcrUoo9RzOB+hcWSOU635DM/CHkyeSss1y+sz9oTFWDAKBLlYXknqp5AVORWoZ4iBaCr
         /Vsg==
X-Gm-Message-State: AOAM530euFU8pbIiNyanqPjC1cwIk3eh6wdwQr6We6+2i1cmANl/a9RV
        6KWomYJbEY5eIRcuKi1rX2jLQIYbL8HT98eGLHJA8aD5H+9Qhw==
X-Google-Smtp-Source: ABdhPJwAE9aYAb62lqaVAn+5C/HRitBJFOGCmFjQVli9rqRiMdLp8QgK1CUfQMmvkEHbXFqXlm2ohDkMTvRT5sTt/eE=
X-Received: by 2002:a25:7c05:: with SMTP id x5mr295678ybc.487.1610507031700;
 Tue, 12 Jan 2021 19:03:51 -0800 (PST)
MIME-Version: 1.0
References: <20210112130538.14912-1-mailhol.vincent@wanadoo.fr>
 <20210112130538.14912-2-mailhol.vincent@wanadoo.fr> <CAMZ6Rq+vwBtUZtHTDQw_1KGFx_VSoep7ZtD3bu6cx5y8VyQFgw@mail.gmail.com>
 <730bfea5-414a-da4b-8404-7dea8e5e9cd3@pengutronix.de> <6b010038-925b-9a52-e332-bcb08f9d9b77@kvaser.com>
In-Reply-To: <6b010038-925b-9a52-e332-bcb08f9d9b77@kvaser.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 13 Jan 2021 12:03:40 +0900
Message-ID: <CAMZ6Rq+G98qMv7TRqPiCEcPOF4GR5uv=2NX5UcA9WNEHYZJSeg@mail.gmail.com>
Subject: Re: [PATCH v10 1/1] can: usb: etas_es58X: add support for ETAS ES58X
 CAN USB interfaces
To:     Jimmy Assarsson <extja@kvaser.com>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed. 13 Jan 2021 at 00:49, Jimmy Assarsson <extja@kvaser.com> wrote:
> On 2021-01-12 16:22, Marc Kleine-Budde wrote:
> > On 1/12/21 4:11 PM, Vincent MAILHOL wrote:
> >> On Tue. 12 Jan 2021 at 22:05, Vincent Mailhol
> >> <mailhol.vincent@wanadoo.fr> wrote:
> >>>
> >>> This driver supports the ES581.4, ES582.1 and ES584.1 interfaces from
> >>> ETAS GmbH (https://www.etas.com/en/products/es58x.php).
> >>>
> >>> Co-developed-by: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
> >>> Signed-off-by: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
> >>> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >>> ---
> >>>
> >>
> >> Something strange is going on with the mailing list.  I can not
> >> see the second patch (1/1) in the *linux-can* mailing
> >> archive (only the cover letter is present):
> >> https://lore.kernel.org/linux-can/20210112130538.14912-1-mailhol.vincent@wanadoo.fr/T/#
> >>
> >> However, the full patch series is present on the *netdev* mailing
> >> archives: https://lore.kernel.org/netdev/20210112130538.14912-2-mailhol.vincent@wanadoo.fr/
> >>
> >> Are there any restrictions in regard to the patch size on the
> >> linux-can mailing list?
> >
> > Not to my knowledge.
>
> I remember having issues posting a large patch.
>
> You probably hit this limit:
> "Message size exceeding 100 000 characters causes blocking."
> http://vger.kernel.org/majordomo-info.html

Thanks!
So, that's the issue. The patch has 161486 characters, way above
the limit...

Marc, is this an issue for the patch review? I have no idea how
to split it in a pretty way.


Yours sincerely,
Vincent Mailhol
