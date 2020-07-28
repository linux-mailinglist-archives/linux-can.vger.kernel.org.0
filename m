Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A87230422
	for <lists+linux-can@lfdr.de>; Tue, 28 Jul 2020 09:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgG1Hb5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 28 Jul 2020 03:31:57 -0400
Received: from mail-db8eur05on2077.outbound.protection.outlook.com ([40.107.20.77]:4928
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbgG1Hb5 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 28 Jul 2020 03:31:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8bALs3XHGjHYULzxpoWYvL7ACUqhs3SnKJASq2gtCumK2mLKdKruLGrL4ysdODlFuG3Q5fTqL5DWMp0DU5ij+W2lEzyZt433S8wFFsTZ1Xpzp7ACz0LKnyifBxuUT96KBKicMqa+h4gjWXMSPYCrqf6rsvhJxLYkHJBNgFC8q/KatJo0iZRJoutbd9Ws32MT6UBjsJH66wQLPVMyhES3wLM1BcFERJBDj12BKZTUHPbK0UI7n7r/zWvEmXQiLxAQaA0YGGTONwMKtSIRHNEvK7+QB9x/mnQcrE+AOQAE2joGlBB+JTS3B77jij6EZPct2Qm96JZvAq9TTvhhum+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgAYf++UMT60mqmeu/KVzgwSTkKgyD+Sz87rvIZNeyI=;
 b=Bh3dsn0G2jCw7rw0fbdwK7pwJgU94Ud5km3I0tpROYrxbOHjDlQO5kiC6ZUpvJDfSSscyaVQRGdlHqzO++nQmvXGpnKuvmSvslhUDtbaw7WhhugsRyxEGmplArIYKHy4XaqrCZZqZLay5zl+yVSAKol1jaLCrrGbjcVuApjlUExlVbADktQjf7668gcVeQ8UVQhBcThQPVJ5R9b8A1lfbHx+ysUrXICSPU9c0MeBQs6ic04M+LQ97nPdcQxaPYZkGCu+GdnOaFVtIw22DUa4D7rq1imILVFUQ+IMLDr+3aRRaW7hjdwinJSSMfMmNZ3FWoYYyko11NYlX9RxjRMyDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgAYf++UMT60mqmeu/KVzgwSTkKgyD+Sz87rvIZNeyI=;
 b=GIt9E32g3YR63+pERIFkv+cfUsmh6z6FB66qt/NJ0LP2WlgOrpdqBex63M+Of+/lY0FA5BpvI/SNhinv/+4Dy6Mlylr3b2LhGRgPKbKn8kkACmWd10J8KFZVmhFFBkLTlX58urHM0XeXG7W10srqdtLHYUSezR791UlagCsMdRQ=
Received: from VI1PR03MB5053.eurprd03.prod.outlook.com (2603:10a6:803:bb::18)
 by VI1PR0301MB2288.eurprd03.prod.outlook.com (2603:10a6:800:26::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Tue, 28 Jul
 2020 07:31:52 +0000
Received: from VI1PR03MB5053.eurprd03.prod.outlook.com
 ([fe80::6816:82a2:7f79:f1a9]) by VI1PR03MB5053.eurprd03.prod.outlook.com
 ([fe80::6816:82a2:7f79:f1a9%5]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 07:31:52 +0000
From:   =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
CC:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: About sysfs usage by socket-can drivers
Thread-Topic: About sysfs usage by socket-can drivers
Thread-Index: AQHWYP9G2WsNUL4tvU6tSrg3yOiV4qkWfDUAgAYfylQ=
Date:   Tue, 28 Jul 2020 07:31:52 +0000
Message-ID: <VI1PR03MB5053EF45CF182D93B68F3FC4D6730@VI1PR03MB5053.eurprd03.prod.outlook.com>
References: <VI1PR03MB5053B1FB7A45D4243BD1F095D6760@VI1PR03MB5053.eurprd03.prod.outlook.com>,<20200724094502.GB27720@x1.vandijck-laurijssen.be>
In-Reply-To: <20200724094502.GB27720@x1.vandijck-laurijssen.be>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vandijck-laurijssen.be; dkim=none (message not signed)
 header.d=none;vandijck-laurijssen.be; dmarc=none action=none
 header.from=peak-system.com;
x-originating-ip: [89.158.154.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45da24be-58ac-4379-8e8f-08d832c84c55
x-ms-traffictypediagnostic: VI1PR0301MB2288:
x-microsoft-antispam-prvs: <VI1PR0301MB22887D8A224B43CB54DDE0C3D6730@VI1PR0301MB2288.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c8yQbvZ3hcgmI41lklSP3zDY6DSIXefL0+tFKINuKClUjWmRuatH3vgpKGvDGcIy/sf40zgdceIUAzMXK8aRLunpZ0KeUiwjDhHA2JkStMKnJCT6rw3XcJyyrveHX/0vBd53E4ZIeZ379EgS7kZSFhngNFnMj2Zjl3Z8IBLEHU2AXcUndOQv4ZWNbPtMWv4cUCwQK+C5woSdaeuT++x/LZ/ndPjeB2EEl61OKWPwNLHjaEiJ1yARe3hLT2wBF7ipQ3/Mwep/7ZYkNLk/1T5Ct+6RjBtBg6Of/D4KBLsmxMbMDBgTq9NLCdxpRox4zr9EmnBScf2tNGyuxiaa/96kPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB5053.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(39840400004)(346002)(136003)(396003)(54906003)(91956017)(83380400001)(8936002)(4326008)(186003)(52536014)(66574015)(66946007)(508600001)(7696005)(66446008)(64756008)(66556008)(6506007)(66476007)(76116006)(33656002)(5660300002)(26005)(2906002)(6916009)(71200400001)(8676002)(15974865002)(316002)(9686003)(55016002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ne5jWXNMtGlf0rdI1DgLb3Q+9LSjPXoclCLLHnRCjRF7Ued33+uQKiCLfM339WoeNVWvIK8ATCONMC4AQr+VLOIydjhYsF+irFJEKkxPmXZpRvAeR7u0skpXUYfHi2NjVEhBbizMTmEsUPcyxUX3gqqfk3Ip+G96qIWBT6eejH2hnWnvvEw8z4Ct/W1m7YMzy6+uwu+aQvEVJ70XmLVoj/yUCh9uL1WbPvHiVfZV66DoEIfRVJ2hlHk1kaQ+lf4CAraguVtmRoFq1V5vXhBOSiQM1aHkH+wbmSSpXRbxqJk6gmxJUoOiUFsEHOHMEcdaI/gcwzfwqMLPnWg4SWp3gMjAEYQlMmwpLKwSKUxLBsz0jJl/gCnbKRI6M+DWThUhNsFAgv88uNwFgM1kWfTzaXSQlYyjJhniK8NxoTlbagEKl8zT6sA4uXhOvMKapdpXq0zdNeGvoXGekEqjplzgreRgFx0eXyiSqs1pW52EOXqWzqMGc6KyBcG5o7qRyu8g
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB5053.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45da24be-58ac-4379-8e8f-08d832c84c55
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 07:31:52.6869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wKSGCsu6HB/lg2EbKBtxxvhS8uEl4PB22PKV0BrYAc7VCMd75OjsrygHW9eq1sonSw+qQ65PLzLOUQaLM4FlGsDhC2hVZt5KPaUJet2h4Pg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0301MB2288
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Thx for your answer Kurt! Even if properties are channel related, this coul=
d be a solution...

But... creating a (new) channel tree under /devices looks weird, doesn't it=
?
And why it should be "easier" to add attributes there rather than under eac=
h /sys/class/net/can?

-- St=E9phane


De : Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Envoy=E9 : vendredi 24 juillet 2020 11:45
=C0 : St=E9phane Grosjean <s.grosjean@peak-system.com>
Cc : Marc Kleine-Budde <mkl@pengutronix.de>; linux-can@vger.kernel.org <lin=
ux-can@vger.kernel.org>
Objet : Re: About sysfs usage by socket-can drivers

> We've several pending requests regarding:
> - changing the default clock value,
> - reading the bus load value,
> - using a flashed device id. to better control the can interface number,
> - identifying the (USB) channel
> - ...

I tend to look in the (in your case) usb device, and add properties there.
After all, those are device-related properties, not?

You could reach them via /sys/class/net/canX/device/...

If you add them before the netdev is registered, you can use them in
udev rules without race conditions.

Kurt

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
Unsere Datenschutzerklaerung mit wichtigen Hinweisen
zur Behandlung personenbezogener Daten finden Sie unter
www.peak-system.com/Datenschutz.483.0.html
