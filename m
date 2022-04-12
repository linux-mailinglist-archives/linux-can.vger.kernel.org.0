Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97484FE879
	for <lists+linux-can@lfdr.de>; Tue, 12 Apr 2022 21:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352699AbiDLTMv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Apr 2022 15:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356455AbiDLTMb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Apr 2022 15:12:31 -0400
X-Greylist: delayed 437 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Apr 2022 12:10:12 PDT
Received: from mx-list-3.rrze.uni-erlangen.de (mx-list-3.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1CE4BBAF
        for <linux-can@vger.kernel.org>; Tue, 12 Apr 2022 12:10:12 -0700 (PDT)
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [131.188.11.22])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-list-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4KdFV60psLz22bJ
        for <linux-can@vger.kernel.org>; Tue, 12 Apr 2022 21:02:54 +0200 (CEST)
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4KdFV56tl3z25SH
        for <linux-can@vger.kernel.org>; Tue, 12 Apr 2022 21:02:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
        t=1649790173; bh=0PMiCgbHplW/h45Pc87FbUjIvQuHXkM4jNyzzuNuRzw=;
        h=To:Subject:Date:From:Reply-To:From:To:CC:Subject;
        b=kAWh8A3FRkpCs5zhRLMcQ7x0COhKYBwIuPM/IwQAG9Lfj+beTGywRlUngnnEr4Q+p
         +emh+z1E1IUHCNsqE0FHOaZ6bPbsH/2PJJAVhD4+4m9QDsu1eyjaWr1fOStxiqhnmb
         N9MI60GEYGR29McOy4gG5U9x9gdVkD3RHdrkgzpfkTBDaF/agN4ed2aHi639/hjIS3
         CTz62AZHShAzrY/NBdnAQ+gjJP42tSiQ+hNa4WfDY4VO2nSaTRyFEwUOipJcjIjNAE
         q8UamK8CcbITnsqoYP9v07+zsLw44nfn8oem5gj2sutjiEYHYOViVgbEBvjFyIPjHu
         N0mY64L+xKV4Q==
X-Quarantine-ID: <FNv2s0zQYK9d>
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Possibly-Spam
X-RRZE-Submit-IP: 10.27.20.43
Received: from cms3.rrze.uni-erlangen.de (cms3.rrze.uni-erlangen.de [10.27.20.43])
        by smtp.uni-erlangen.de (Postfix) with ESMTP id 4KdFV32M8zz22bJ
        for <linux-can@vger.kernel.org>; Tue, 12 Apr 2022 21:02:51 +0200 (CEST)
Received: by cms3.rrze.uni-erlangen.de (Postfix, from userid 33)
        id 4EFEF64060C; Tue, 12 Apr 2022 21:02:51 +0200 (CEST)
To:     linux-can@vger.kernel.org
Subject: =?UTF-8?Q?Anmeldung_Pflanzenb=C3=B6rse_=E2=80=9E?=  =?UTF-8?Q?=F0=9F=A5=B0_All_the_girls_from_next_door_are_here?=  =?UTF-8?Q?_with_their_cams!_Visit_cam:_http://inx.lv/NoVW=3F?=  =?UTF-8?Q?k4v5i_=F0=9F=A5=B0=E2=80=9C?=
X-PHP-Originating-Script: 33:PHPMailer.php
Date:   Tue, 12 Apr 2022 19:02:51 +0000
From:   Botanischer Garten Erlangen <webmaster-botanischer-garten@fau.de>
Reply-To: webmaster-botanischer-garten@fau.de
Message-ID: <fQmkoe6V0Z4NUnIMC73NLCFrfh7wydxL5wzMDIN7S6M@cms.rrze.uni-erlangen.de>
X-Mailer: PHPMailer 6.5.3 (https://github.com/PHPMailer/PHPMailer)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PLING_QUERY,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Verkäufer: 🥰 All the girls from next door are here with their cams! Visit cam: http://inx.lv/NoVW?k4v5i 🥰 
Telefon: 945521278339
k5sddrz

Stand:
Tischlänge: 3 m
Angebot: Sonstiges: 5y67p3e1

Anmerkungen:
omv1bc

Beginn der Pflanzenbörse 9:00 Uhr,  Aufbau ab 7:00 Uhr möglich

Die Grund-Standgebühr beträgt  pro Aussteller 12 € bei einer Standgröße bis 2 m². 
Überweisen Sie diesen Betrag  bitte im Voraus auf das Konto des FBGE bei der Sparkasse Erlangen: 
IBAN DE 73 7635 0000 0000 087827, BIC BYLADEM1ERH. 
Die Anmeldung ist erst mit dem Eingang der Grund-Standgebühr gültig! Sie erhalten von uns eine Eingangs- bzw. Anmeldebestätigung.

Sollte Ihr Stand größer sein, dann kostet jeder weitere m² 12 €. Diese Zusatzkosten werden vor Ort erhoben.

Rückfragen und Infos unter 09131/8522969 oder botanischer-garten@fau.de

Sollten Sie nicht teilnehmen können, sagen Sie Ihre Teilnahme rechtzeitig telefonisch oder per e-Mail ab.
Bei einer Absage der Teilnahme bis 2 Wochen vor dem Veranstaltungstermin wird der bereits bezahlte Betrag zurück überwiesen. Bei späterer Absage erfolgt keine Rückerstattung.

-- 
Diese E-Mail wurde von einem Kontaktformular von Botanischer Garten Erlangen (https://www.botanischer-garten.fau.de) gesendet

