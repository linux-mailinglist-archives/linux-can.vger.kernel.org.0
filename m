Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B104660247
	for <lists+linux-can@lfdr.de>; Fri,  6 Jan 2023 15:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbjAFOdu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Jan 2023 09:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbjAFOdX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Jan 2023 09:33:23 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894B180AC2
        for <linux-can@vger.kernel.org>; Fri,  6 Jan 2023 06:33:02 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id p66so807297iof.1
        for <linux-can@vger.kernel.org>; Fri, 06 Jan 2023 06:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eitTHaXGAas6RiUhUstkoB1912ls1ebaROraxJ/kDps=;
        b=U7H8u4kEmtE/teUspwme1teQy1IJIWilQxYvA21N79zj3l7yp4SijvmpmH7NoP/usd
         exZMTBu1krq3mXf6iPGFqW/5P5dv0Wj2DXe5z5bgk6T9iUnywk2VbshSXSujZC8XGv6k
         ZmmzWdxlPhr+PLw7QXO7gzOcBlIc0jnWSxiX725EOhD23Xh5Zg9aF+8TYmPM3jz1/Ieq
         Lop4p1la6izTSr0SrJqD95DftspBkzEzYvh5idt8y7xWlBtp0QBAls5QfFU3zDbLFpeH
         ekWPFB6vQkYmc+A7wnzodq8m+7bODJ82TUy5MhnzzkONFZkq2sHWyHc7iXwCobrTpHD8
         /2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eitTHaXGAas6RiUhUstkoB1912ls1ebaROraxJ/kDps=;
        b=BBfNo+HBd2jIe+YmrMEktKwBf7iKlwM2JtnbpZ3DujXg3cTh3EEypob/ugV01pM9iq
         F226+GPA3QjD3CpL75GC2GNsUjq6rkz82jkPs0DfyjbCY0RfyeFwaz+E3t+8DW9pN7dK
         4jm9NwhUhsfn8XI4bnkw9yR+T/k3+bvNMm0NWCNwLLuxDVxHdHXPZ4PNbEgnA2JxD412
         kW8wiedBfwXtMR++Bg3GOhVbQlPsai06n4JJ9m//3uCURi8GVYi6T7ASTJPrw3sslok2
         Tz1hXzvCNQVbV1sDRdbDxjXa1iAGaUiDUKZGYHoYvfI8PuUnol+FrX3Z3dvO/IJve+oe
         rpDw==
X-Gm-Message-State: AFqh2krqKQUy8304rc1f7jXE6cooh+IRjfsSsGr6fwUld+mc7xrw9E3j
        l+wWs0Qk6kHEmSsWydCc6GrxLJfkHl2LSsWSMuU=
X-Google-Smtp-Source: AMrXdXuoZeZ5/F5/8cLeZQqMzUCivtezJtqN3rXnBPVEGiK8lXQZZyTP/++ugdeNfqmqTs8Ooz/ocXIUOtSDcym/4hw=
X-Received: by 2002:a05:6602:18a:b0:6ed:13b9:2e1e with SMTP id
 m10-20020a056602018a00b006ed13b92e1emr4561931ioo.172.1673015581862; Fri, 06
 Jan 2023 06:33:01 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6638:12cc:b0:395:c7de:f14c with HTTP; Fri, 6 Jan 2023
 06:33:01 -0800 (PST)
Reply-To: abrahammorrison443@gmail.com
From:   Abraham Morrison <awochambers004@gmail.com>
Date:   Fri, 6 Jan 2023 06:33:01 -0800
Message-ID: <CAH2diS4kgh2hDHcecxeEJ6EiQRR_F=HTT1X4QLj59zmFYMRoSw@mail.gmail.com>
Subject: Good day!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d42 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [awochambers004[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [abrahammorrison443[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [awochambers004[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.4 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Aufmerksamkeit bitte,

Ich bin Mr. Abraham Morrison, wie geht es Ihnen, ich hoffe, Sie sind
wohlauf und gesund? Hiermit m=C3=B6chte ich Sie dar=C3=BCber informieren, d=
ass
ich die Transaktion mit Hilfe eines neuen Partners aus Indien
erfolgreich abgeschlossen habe und nun der Fonds nach Indien auf das
Bankkonto des neuen Partners =C3=BCberwiesen wurde.

In der Zwischenzeit habe ich beschlossen, Sie aufgrund Ihrer fr=C3=BCheren
Bem=C3=BChungen mit der Summe von 500.000,00 $ (nur f=C3=BCnfhunderttausend
US-Dollar) zu entsch=C3=A4digen, obwohl Sie mich auf der ganzen Linie
entt=C3=A4uscht haben. Aber trotzdem freue ich mich sehr =C3=BCber den
reibungslosen und erfolgreichen Abschluss der Transaktion und habe
mich daher entschieden, Sie mit der Summe von $500.000,00 zu
entsch=C3=A4digen, damit Sie die Freude mit mir teilen.

Ich rate Ihnen, sich an meine Sekret=C3=A4rin zu wenden, um eine
Geldautomatenkarte =C3=BCber 500.000,00 $ zu erhalten, die ich f=C3=BCr Sie
aufbewahrt habe. Kontaktieren Sie sie jetzt ohne Verz=C3=B6gerung.

Name: Linda Kofi
E-Mail: koffilinda785@gmail.com

Bitte best=C3=A4tigen Sie ihr die folgenden Informationen:

Ihren vollst=C3=A4ndigen Namen:........
Deine Adresse:..........
Dein Land:..........
Ihr Alter: .........
Ihr Beruf:..........
Ihre Handynummer: ...........
Ihr Reisepass oder F=C3=BChrerschein:.........

Beachten Sie, dass, wenn Sie ihr die oben genannten Informationen
nicht vollst=C3=A4ndig gesendet haben, sie die Bankomatkarte nicht an Sie
herausgeben wird, da sie sicher sein muss, dass Sie es sind. Bitten
Sie sie, Ihnen die Gesamtsumme von ($ 500.000,00) Geldautomatenkarte
zu schicken, die ich f=C3=BCr Sie aufbewahrt habe.

Mit freundlichen Gr=C3=BC=C3=9Fen,

Herr Abraham Morrison
