Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4B21FBE4B
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2020 20:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgFPSlC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 16 Jun 2020 14:41:02 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:16294 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbgFPSlC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 Jun 2020 14:41:02 -0400
Date:   Tue, 16 Jun 2020 18:40:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1592332859; bh=mU0X2u5ucljq7A9cKdfB9iq+d3eTTpDgJiDIPl2sG0I=;
        h=Date:To:From:Reply-To:Subject:From;
        b=a2W+eG/bCmof1tsYFy70ZGbUqPo0fOZdO2WjO5L9QN3Ypp9mhn7+zBt/m5R0sRueo
         GT3ius0Yl77dWWkiiP4bFFdqjZ2uqt8ja9jLOY5lBNRRknYH2E+Pd2AeXlJvB+tjK4
         OmsujeNhqw9kYvAtYmqE1gvpSXYIJgeFAh1Vrt0jrestXpQt3fgdvju3yhWpylNi66
         aM95JMzS/DWHX0owMBfwuvwEyJOdFoauK24i/MBMEO/nmNifCiIVxrm0jXSRlEf4fJ
         N9+Z5mljITFH+6NUq/kHAlUSdVlvF6A3LkHQqtj66XMWL0ybKIEgtKkqMWf+w8J2B5
         ijYDAVD2UIJzg==
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
From:   Arnej Duranovic <arnejduranovic@pm.me>
Reply-To: Arnej Duranovic <arnejduranovic@pm.me>
Subject: J1939: /proc/net/can interface
Message-ID: <4SjA_8nFwOgutMJ5YoVaQPwX-zU-3shqgm7lsWxNWIQas0hIsCMdujJJbEJXOdxFjnDlDTqaDs4yiOXhAgZUYDUKIHXKcwtih3aa1fL8LV4=@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.protonmail.ch
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello all,

Earlier versions of J1939 contained the following:

+ 6. /proc/net/can-j1939 Interface.
+ --------------------------------
+
+   Files giving you a view on the in-kernel operation of J1939 are located=
 at:
+   /proc/net/j1939.
+
+ 6.1 /proc/net/can-j1939/ecu
+
+   This file gives an overview of the known ECU's to the kernel.
+   - iface : network interface they operate on.
+   - SA : current address.
+   - name : 64bit NAME
+   - flags : 'L' =3D local, 'R' =3D remote

I am interested in what happened to this feature since I do not see it in t=
he latest implementation or in the documentation?

I am interested in retrieving "known ECU's to the kernel" in the latest imp=
lementation. What is recommended?



