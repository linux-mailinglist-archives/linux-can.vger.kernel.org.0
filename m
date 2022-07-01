Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F70563C68
	for <lists+linux-can@lfdr.de>; Sat,  2 Jul 2022 00:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiGAWeb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 1 Jul 2022 18:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiGAWea (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 1 Jul 2022 18:34:30 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592953631D
        for <linux-can@vger.kernel.org>; Fri,  1 Jul 2022 15:34:30 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id w83so5391009oiw.1
        for <linux-can@vger.kernel.org>; Fri, 01 Jul 2022 15:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=e/r0L/PAnS5fOVQg6qj0+2DIJq2t1BxWauF5ORbF6tY=;
        b=nZq/erbG+DSgnOXLTD4hPW1ogQi042xJwYGe2K60StKlksM3R80e8g55Oinmujijfa
         FfIC4NFW1kCcfgo5X9JaW/IlSZnJNwoWgdDpalYaFmNf6lrsMllZiIs1G558KouIJU2C
         9vSDZ1pUbUBzZ2akz3+2Q0i8LheSieQxvOU23Z0+qPDnf9WSS79KRZGvu/g9/AfcKBH5
         Ip0C7kXXSgMkrFmwCmF8VFzp8FXUnvaIvwtNk3XUxIo9VOkXNI/AZCe7SnuTg4uklDGx
         Z/XFrg/WKX0sNp8wRf5XxdGMa0ccn9GybfnMcisxGRVPBgNePETUgUJqnrLfBslEP6qZ
         K1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=e/r0L/PAnS5fOVQg6qj0+2DIJq2t1BxWauF5ORbF6tY=;
        b=JRqxvtOMZ/mNGWiCqWuHKXelu97royZ3yMbOmvpii65deX+87WtrI+UXwObaHhZ908
         UYuZ/3mkPpuHHtg2lxwbGyYq26+LLng/BNF6cQYUWWKOt3R/LA468+yFfPpc3LklIfgy
         ohhUJJWfyFKPaGFWx2z80pUEN8J+l4qwdsiSeJFiDh+JxbLFGh3AXjwuvrtry6ExOeWZ
         42xI2xRHDqu66oYQ161IpbJMyw0Fsz8Ma3z5O3hSfCaxFZgPyhkkjPmij41m0rcS8u6s
         n6cRthv8sGINL9S8po192+FJxqdr4WsuV/GEiprElGkAnfk8OPR9Rv/VmFO5qVbLlQbw
         qzhw==
X-Gm-Message-State: AJIora8DDKen/RdD1qzF2fG6OzLp5BPVQnkmnNMd/84I8lYkK2r2puFR
        IlgCRKiomHMQTWABd+qnMeqSEdWkJUS8U/nyyCs=
X-Google-Smtp-Source: AGRyM1uB4/sIOdayVv0fD1UQhgnlOpoSUa5rXEksL+UCYm0qQA4dCzscj5mypkF3ggtTgnQ6vAuVescxNb2HGEyF5q0=
X-Received: by 2002:a05:6808:68e:b0:335:4901:1b2f with SMTP id
 k14-20020a056808068e00b0033549011b2fmr9829359oig.149.1656714869719; Fri, 01
 Jul 2022 15:34:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:d850:0:0:0:0:0 with HTTP; Fri, 1 Jul 2022 15:34:29 -0700 (PDT)
Reply-To: georgebrown0004@gmail.com
From:   george brown <moordavis0002@gmail.com>
Date:   Sat, 2 Jul 2022 00:34:29 +0200
Message-ID: <CALTCcCxmgfe0x9b7qzETQ3_h2PQNu8p7CovkkeO5LLxWPeQeaA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.7 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Ahoj

Jmenuji se George Brown, povol=C3=A1n=C3=ADm jsem pr=C3=A1vn=C3=ADk. Chci v=
=C3=A1m nab=C3=ADdnout
nejbli=C5=BE=C5=A1=C3=AD p=C5=99=C3=ADbuzn=C3=BD m=C3=A9ho klienta. Zd=C4=
=9Bd=C3=ADte =C4=8D=C3=A1stku (8,5 milionu $)
dolar=C5=AF, kter=C3=A9 m=C5=AFj klient nechal v bance p=C5=99ed svou smrt=
=C3=AD.

M=C5=AFj klient je ob=C4=8Dan va=C5=A1=C3=AD zem=C4=9B, kter=C3=BD zem=C5=
=99el p=C5=99i autonehod=C4=9B se svou =C5=BEenou
a jedin=C3=BD syn. Budu m=C3=ADt n=C3=A1rok na 50 % z celkov=C3=A9ho fondu,=
 zat=C3=ADmco 50 % ano
b=C3=BDt pro tebe.
Pro v=C3=ADce informac=C3=AD pros=C3=ADm kontaktujte m=C5=AFj soukrom=C3=BD=
 e-mail zde:
georgebrown0004@gmail.com

P=C5=99edem d=C4=9Bkuji,
Pane George Browne,
