Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC212EE756
	for <lists+linux-can@lfdr.de>; Thu,  7 Jan 2021 22:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbhAGVBH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 7 Jan 2021 16:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbhAGVBG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 7 Jan 2021 16:01:06 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E3BC0612F4;
        Thu,  7 Jan 2021 13:00:26 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id a12so17871120lfl.6;
        Thu, 07 Jan 2021 13:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TDGjxNGdIvKGTz1RqVHsJx9rmYUxdAE5tYyDcXk5jTQ=;
        b=kUYBr3OG39fnEGEH0ZslmY12Vl6P1xY2WKtwZXIwNnCI+lC/OczlzAJBF8wR3VKshH
         IhZ5xM04ph36V+2zqJkVnDhpfyYh9ZipMvIv9wgVFcT0v+XBm4+rYjAtmCppprlesoI3
         FYPHtH7DO0/4VVvfiOlj4IE3CxW6gl0FpvCQsXdxzFfnvAOY8NTWRdHAvl/HZA50vUGN
         psMzKkYxltrpGWvtcyyZ11ZNYAEZe+JFCgiYrLqXl7kn/Bi7JuJ0iigaq2MJJWiNUAwg
         Wx/nUfk8E7MVxJCbRt4Vb5CRt7dwzikDzz1oBP90yyBW+WsVA7k/sbn8QXfUwqsFwbco
         9cNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TDGjxNGdIvKGTz1RqVHsJx9rmYUxdAE5tYyDcXk5jTQ=;
        b=jbhiklUq34eF05VRfG2eOqn4dt+5endoz81IPgCVEq6Eo9FOSvHUxFeCHsf7QYKlxo
         AjOgzzkSr1+VeZMU4D9vB5DQlOYmSQW1UBCc4lGc2cXxpCamQ0A7EabuNj8mljNmj1RQ
         ISKUT/eCx76ccFNn0LuMAyDkQqfyFBnm/FTLpYifsarMFL9pPp04QpXovokmKVWCFyng
         N9U33S8Z+RSlTiD+usd3ljD0oe3rEJ03y6gmiml8fO1AvShO5q7EjGdOFkXZATfgh5dz
         SQmjaithoAZ7vCLEKFveLOXB7eo2/tnOQDjJBYoXRUg4nLFn3R2a30or0YtTxvDZm/2E
         Am+A==
X-Gm-Message-State: AOAM5305tVTRrNNoPfkKAPrIwYqe9uZL3tUF2KSxebp8jGF2nAatt5br
        GBmjlpmBCv1vjsN8W4t5c/BO95tBix4NeDT+T9qdUUEaC6w=
X-Google-Smtp-Source: ABdhPJyAMtOrgx/9PdIWegP7iILJzCrS9S3IYx+TYNYT9Ms/X75gsJIeSz2sORiEKJEVYow9fgk8nMZVzpb07iLt/kU=
X-Received: by 2002:a2e:b556:: with SMTP id a22mr131647ljn.264.1610053224924;
 Thu, 07 Jan 2021 13:00:24 -0800 (PST)
MIME-Version: 1.0
References: <CAOMZO5AZYVcsMq=oE-Q_aDCEGrJEH9K5p1uqFzoUeiy3tg1SMQ@mail.gmail.com>
In-Reply-To: <CAOMZO5AZYVcsMq=oE-Q_aDCEGrJEH9K5p1uqFzoUeiy3tg1SMQ@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 7 Jan 2021 18:00:12 -0300
Message-ID: <CAOMZO5DPPRSi=4S=oFxuy5iCcXm1jJ33zkdHu+h9Xf2+7raw4g@mail.gmail.com>
Subject: Re: Describing the STB pin of the CAN transceiver
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Jan 7, 2021 at 2:38 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi,
>
> The imx6ul-evk uses a MC34901 CAN transceiver and the STB pin
> (standby_ needs to be controlled (1 = standby, 0 = normal mode)
>
> As far as I can see, there is no support for the STB pin currently in
> he can framework.
>
> What would be the correct way to describe it in the devicetree?
>
> Would it be acceptable to use something like this?
> https://pastebin.com/raw/SsY6USdT

I made a simpler approach and submitted patches for review.

Thanks
