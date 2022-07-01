Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15504563863
	for <lists+linux-can@lfdr.de>; Fri,  1 Jul 2022 19:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbiGARCY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 1 Jul 2022 13:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiGARCW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 1 Jul 2022 13:02:22 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0121C11C26
        for <linux-can@vger.kernel.org>; Fri,  1 Jul 2022 10:02:21 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id t25so4871017lfg.7
        for <linux-can@vger.kernel.org>; Fri, 01 Jul 2022 10:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hL3FSbI92kNEPtSXO4UdY1q30oPk9HXbwNeYCXnhjnU=;
        b=m4+HCIu2JSG6zl+qUo3Giox3+lbCc2sdNYbVUymPcLx6mWBd3bFk7jauxO4wsJQpxu
         dR+RJ2iEBWQLFkgN8CKuVe8pDbdPl35MqTp5ENe0mZoow8zebgY8q2h8D82+Fy+8PYen
         hu+Lo/AzdX/v8qo/ROIM2JOveg+XqqB32EMZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hL3FSbI92kNEPtSXO4UdY1q30oPk9HXbwNeYCXnhjnU=;
        b=WySovnECJBV3Zhm4AuExQgE1jP+0m8GUPlp4cZKd6CRg1gp36gj06xdzGUBSR7DGDo
         7DUMgu7Y2fIqjunCqYChH/POQ+6K6NzuphiOS97r1K9davCsJaFKoAcYcE3eCG1DoT5l
         +6laBvG0HuoE3jGDuj4hVmEyYpsnVZF/IwOopB4PkPtHuUXnBy82dIbf635mNUM1PH9V
         RpJ3OvmkFjlPXq4YVo5J247SEkXFW37fWmOqX+2sI9DCWLGZcL/XAt9gR0+qpEHsg7Mt
         dmG7A5tGIFmGEc5SQgeHcMznsifa4FNHONXMry9gf2CpzL1812K5l8Qzj8HS8cN+m+s2
         wv/Q==
X-Gm-Message-State: AJIora9MoURv3FFHRHMi0DIDiQDfUFsdgIty39VBTDij05Za7BsuiwJo
        gkW87P16s/aain8OTHDmjRD9ZJJDUqY72gnaI/rvAQ==
X-Google-Smtp-Source: AGRyM1sthbFfplAH1y2o08/7TXtDhHD019NNQhPy2ioCaaIIyTJHm6ZhXRnUFGJ577gtCZzkbN8pBA7dWvdN/J785YM=
X-Received: by 2002:a05:6512:3b08:b0:481:1b90:bf55 with SMTP id
 f8-20020a0565123b0800b004811b90bf55mr10171553lfv.153.1656694939257; Fri, 01
 Jul 2022 10:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220628163137.413025-1-dario.binacchi@amarulasolutions.com> <cc2e57b8-5b29-11b8-aa7f-fea7ac96d68a@victronenergy.com>
In-Reply-To: <cc2e57b8-5b29-11b8-aa7f-fea7ac96d68a@victronenergy.com>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Fri, 1 Jul 2022 19:02:08 +0200
Message-ID: <CABGWkvpMsFBOAXx+ihH8s8=d8Z4-MqRSPWX_eWSd9F+PH4TKww@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] can: slcan: extend supported features
To:     Jeroen Hofstee <jhofstee@victronenergy.com>
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Jeroen,

On Fri, Jul 1, 2022 at 6:36 PM Jeroen Hofstee
<jhofstee@victronenergy.com> wrote:
>
> Hello Dario,
>
> On 6/28/22 18:31, Dario Binacchi wrote:
> > This series originated as a result of CAN communication tests for an
> > application using the USBtin adapter (https://www.fischl.de/usbtin/).
> > The tests showed some errors but for the driver everything was ok.
> > Also, being the first time I used the slcan driver, I was amazed that
> > it was not possible to configure the bitrate via the ip tool.
> > For these two reasons, I started looking at the driver code and realized
> > that it didn't use the CAN network device driver interface.
> >
> > Starting from these assumptions, I tried to:
> > - Use the CAN network device driver interface.
> > - Set the bitrate via the ip tool.
> > - Send the open/close command to the adapter from the driver.
> > - Add ethtool support to reset the adapter errors.
> > - Extend the protocol to forward the adapter CAN communication
> >    errors and the CAN state changes to the netdev upper layers.
> >
> > Except for the protocol extension patches (i. e. forward the adapter CAN
> > communication errors and the CAN state changes to the netdev upper
> > layers), the whole series has been tested under QEMU with Linux 4.19.208
> > using the USBtin adapter.
> > Testing the extension protocol patches requires updating the adapter
> > firmware. Before modifying the firmware I think it makes sense to know if
> > these extensions can be considered useful.
> >
> > Before applying the series I used these commands:
> >
> > slcan_attach -f -s6 -o /dev/ttyACM0
> > slcand ttyACM0 can0
> > ip link set can0 up
> >
> > After applying the series I am using these commands:
> >
> > slcan_attach /dev/ttyACM0
> > slcand ttyACM0 can0
> > ip link set dev can0 down
> > ip link set can0 type can bitrate 500000
> > ethtool --set-priv-flags can0 err-rst-on-open on
> > ip link set dev can0 up
> >
> > Now there is a clearer separation between serial line and CAN,
> > but above all, it is possible to use the ip and ethtool commands
> > as it happens for any CAN device driver. The changes are backward
> > compatible, you can continue to use the slcand and slcan_attach
> > command options.
>
> Many thanks,
>
> For what it is worth, up to "Send the open/close command to the adapter
> from the driver.", I cherry-picked this back to 5.10. That seems to work.
>

For me it is meaningful feedback.
Thank you very much

With kind regards,
Dario

> With kind regards,
>
> Jeroen
>
> [1]
> https://github.com/victronenergy/linux/compare/v5.10.109-venus-5...victronenergy:linux:v5.10.109-venus-6?expand=1
>
>


-- 

Dario Binacchi

Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
