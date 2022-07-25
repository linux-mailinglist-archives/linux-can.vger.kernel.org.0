Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46E75800BB
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 16:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbiGYO3q (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 10:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbiGYO3p (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 10:29:45 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D948DEA0
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 07:29:44 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id f73so20316728yba.10
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 07:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PddyttDL82dIWKDAL/AxtKVkse3S9YfjUKdUvOV7/TM=;
        b=RkHL5Op0uiIgO39sX5YrjbmwVql4EGpZZ0wK0aRyInmfKCUCkn4aCv+6U7G2UFI6Vj
         8vgTPIrdEiJJGsJWFy8Ruu0x97pqrPV57jQ1NOrmeYV8BKiTXwMq2gpHHsEDIa0x8Vo4
         SPDZSSvOvSBgSJj/3D5k3kIf6oiHLTYRdben/xCZJ5L2dOly1/lx06SOFZT204gYVIXG
         yuxFX+8TFXxeDBh6cxete/liFsuoqbu9dO3kk7JgC5Fw6NgYSFJsatk9JlDazbj2JTbm
         rmF2F/rtfIp/MIoya0ygunPuQWfLmcpImgo6tcw01cyjBzrObo5tBLUUBMLPSCzFhxSS
         SjTA==
X-Gm-Message-State: AJIora+UORfdeAEQtLNSQqlyJb8uAAS7jnuZ0nTHQ5IMqu/Y5IptiYf9
        vxzr6Ynx5IcvN1V8RRFF4aUqnUIAy2U0n/MVrxI=
X-Google-Smtp-Source: AGRyM1v1Hz7HzlraPUlPLqeeAfzoVJJ+WxdRMdRNwtvFKXZgrWbVa9eSoVj0qcSLh6ija+iCCCt+iB1ZTn4ylvF7DLk=
X-Received: by 2002:a5b:ed0:0:b0:670:7cd1:a756 with SMTP id
 a16-20020a5b0ed0000000b006707cd1a756mr9789966ybs.151.1658759383752; Mon, 25
 Jul 2022 07:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
 <20220725133208.432176-11-mailhol.vincent@wanadoo.fr> <20220725140911.2djwxfrx3kdmjeuc@pengutronix.de>
In-Reply-To: <20220725140911.2djwxfrx3kdmjeuc@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Mon, 25 Jul 2022 23:29:32 +0900
Message-ID: <CAMZ6RqLc8CNy2KoPNwvRux0UKD=NAtO7Uoe57Rmvy3ZH+g3JyQ@mail.gmail.com>
Subject: Re: [PATCH v1 10/24] can: tree-wide: implement ethtool_ops::get_drvinfo()
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon. 25 Jul. 2022 at 23:09, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 25.07.2022 22:31:54, Vincent Mailhol wrote:
> > For all CAN drivers, implement the get_drvinfo() function.
> >
> > After this patch, it is now possible to retrieve basic information by
> > doing:
> >
> > | $ ethtool -i canX
>
> This is the output of unpatched mcp251xfd driver.
>
> | $ ethtool -i mcp251xfd0
> | driver: mcp251xfd
> | version: 5.18.10-v8+
> | firmware-version:
> | expansion-rom-version:
> | bus-info: spi0.0
> | supports-statistics: no
> | supports-test: no
> | supports-eeprom-access: no
> | supports-register-dump: no
> | supports-priv-flags: no
>
> (v5.19/patched is currently compiling}
>
> IMHO there's no need to implement a default .get_drvinfo callback. BTW:
> I removed one from the c_can driver some time ago:
>
> https://lore.kernel.org/all/20220124215642.3474154-10-mkl@pengutronix.de/

Oh! struct ethtool_ops does not document that .get_drvinfo has a
default implementation. I will remove it. With this removed, patch 1
to 9 are not related anymore so I will split the series in two.


Yours sincerely,
Vincent Mailhol
