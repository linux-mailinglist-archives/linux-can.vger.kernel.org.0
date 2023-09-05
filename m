Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900B2792996
	for <lists+linux-can@lfdr.de>; Tue,  5 Sep 2023 18:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351134AbjIEQ1Q (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 5 Sep 2023 12:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353806AbjIEITL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 5 Sep 2023 04:19:11 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0E9CE0
        for <linux-can@vger.kernel.org>; Tue,  5 Sep 2023 01:19:05 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-64c1d487e72so13588146d6.0
        for <linux-can@vger.kernel.org>; Tue, 05 Sep 2023 01:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693901944; x=1694506744; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CvUmRYKO5rN5JiKdYLn9/Xxm/soJiVGtQm650JnL3Yc=;
        b=IDuf0baB1t1F8QSCLjWC8pmRvzAKQ/R4M4t5u3FLsOX2SqRgQXz/Z3MpAk8Vd5Kb6m
         OBaz+r/ujIbUuNkrji3TkmDn2dTAwQpGpPSmDRQp7o69pvQ/Nlbne7CwWkb0CdLrrzzk
         IN5sVqz4WX/cEw2uA94JE67yTGlOm8wzR3yOF0SXEPyJnQGBjepPHYJlqPiS3zq3DGfU
         I2yXoCdrDFdm20VoyBK97sKFjeM/5AIhQp1In2otrpCJ9z7tTsw9ci7s0XR+LUbYUzXt
         uod929b61k889o1RxRCphXZmWycOoUHC60HIKvs/decRlJjUBc58LQQ4Se5bQ0loDS6t
         OnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693901944; x=1694506744;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CvUmRYKO5rN5JiKdYLn9/Xxm/soJiVGtQm650JnL3Yc=;
        b=bTb3m3o2lR6Fm8Gfnp5NmUO4gnv+ldFoEJEABE+BVHGNZSUSena5EmdQSxgQqGy48s
         uUZYnaSBHXdib3QYlXNf7EDLKpjVWCL3ZNZSUwUkTv/SxgDLUufqVA1eEUIi9vyVirRx
         0FeslY5/hhsCgYYPHvAGUjszpCGudMjQzeDkf8yJO9DY8isvZdiTkXnE6ieC7CDYAGmh
         d3nuwsRBk1grQhoCbUKiwSf/RAhJesYhW4QcoKBWIOV82dJaaHN++p7d+xcJQmrJlwBl
         CkmYz9he8SrhtdnIaF7weopj48iFmxMikMsz3Lvm7ar126YLboXApHgH3k4zuAAD62JU
         f8xA==
X-Gm-Message-State: AOJu0YxhhJQXzhe7wCK159TZxH84FtDnRk3wyzF1wtJIwUdb3OWuh37Y
        qwDvPtf7lzYhVny2qSpqgrdgmy8job8cz0Ao0XU=
X-Google-Smtp-Source: AGHT+IERAX8PQb3+O/VRt2IpdT+B8+AIRhc7TR9qfBXEywqtD/tUeMqNmseulSPs3fS452xIhVN8tbhQYqX1LXl34po=
X-Received: by 2002:a0c:aa1b:0:b0:653:5736:c0b4 with SMTP id
 d27-20020a0caa1b000000b006535736c0b4mr10412089qvb.54.1693901943569; Tue, 05
 Sep 2023 01:19:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:de0e:0:b0:634:8588:8dcb with HTTP; Tue, 5 Sep 2023
 01:19:02 -0700 (PDT)
Reply-To: wuwumoneytransfer5000@hotmail.com
From:   "(IMF) SCAM VICTIMS" <smmab4668@gmail.com>
Date:   Tue, 5 Sep 2023 01:19:02 -0700
Message-ID: <CAPvhgiGb_xchv+cBfjtNXZbs3T38s2BJRqmONSNBDUeOvUkr=Q@mail.gmail.com>
Subject: Betrugsopfer
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Sehr geehrter E-Mail-Besitzer,



Der Internationale W=C3=A4hrungsfonds (IWF) entsch=C3=A4digt alle Betrugsop=
fer
und Ihre E-Mail-Adresse wurde auf der Liste der Betrugsopfer gefunden.

Dieses Western Union-B=C3=BCro wurde vom IWF beauftragt Ihnen Ihre
Verg=C3=BCtung per Western Union Money Transfer zu =C3=BCberweisen.

Wir haben uns jedoch entschieden Ihre eigene Zahlung =C3=BCber Geldtransfer
der Westunion in H=C3=B6he von =E2=82=AC5,000, pro Tag vorzunehmen bis die
Gesamtsumme von =E2=82=AC1,500.000.00, vollst=C3=A4ndig an Sie =C3=BCberwie=
sen wurde.

Wir k=C3=B6nnen die Zahlung m=C3=B6glicherweise nicht nur mit Ihrer
E-Mail-Adresse senden daher ben=C3=B6tigen wir Ihre Informationen dar=C3=BC=
ber
wohin wir das Geld an Sie senden wie z. B.:


Name des Adressaten ________________

Adresse________________

Land__________________

Telefonnummer________________

Angeh=C3=A4ngte Kopie Ihres Ausweises______________

Das Alter ________________________


Wir beginnen mit der =C3=9Cbertragung sobald wir Ihre Informationen
erhalten haben: Kontakt E-Mail: ( wuwumoneytransfer5000@hotmail.com)


Getreu,


Herr Anthony Duru,

Direktor von Geldtransfer der Westunion
