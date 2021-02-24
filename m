Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9554324123
	for <lists+linux-can@lfdr.de>; Wed, 24 Feb 2021 17:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhBXPm2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 24 Feb 2021 10:42:28 -0500
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:64270
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235279AbhBXO2U (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 24 Feb 2021 09:28:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBaiZpfWYEhpvKCIBMBDJyr8OcUmAMjsaAaP231XlZqDek1mpCf3x0vSPWVZKdoAMQGz6xrY5KNv9j3v6CYdtx0P59QuANTY38MIEtIVEUpFzxd83BOCsVFPhRuw/YT/z0TVdZT3v+AoD5Xe8/WifshgGaDAbnk71MqYItdB8WYES4enWb/XxCZCTrzouuqWRROsE3rUmON7DnocMfO7XhQjf2lB7rSw2ppi8Urba8CamSD+iKbGc8XT5LCWPYbzBlHGxY/Zr/IyQrR2r5NxAC1tQ5HmGql/mNzDPYIliqZwQNRYz8yryUSgoqNp0s/QTy/Y3JLTNsXdOyT0i9yBng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1YfNtmoLYm4d06ul4eu9DZrtIkZrtK7FGfURlJbd0k=;
 b=DHhs6R2OIzThOrFDS9loI2oOKXZIKFEhQjSnQtsFKFKpFAG79bBx4rszbidTHxQQiolHGssdApRwRbM4poa+lBDP3Wr7ceqK+Rh2NtOAftDwP0UnOvJyRlwtkqbYahDHlu4jFift1g6mqaCxv3CiRIldFlo3rLPdfr9jI1ZnICv8OjQj8CNinaFndhFnnXRD97sQnFZR9E/88hRG9b/G6qS2nRNjBOuQIZMRVfaBLkYCxMd8wMgHjJcZ7+a80RVt7+ADvOvUwmKE3z7NLytQofsIkgUNPKZ2hczZR/W6g92zTRf7ItuPUhGfo7fQnLq1WE13W81YtKkza22QN19L+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xtrack.com; dmarc=pass action=none header.from=xtrack.com;
 dkim=pass header.d=xtrack.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=XTrackCOM.onmicrosoft.com; s=selector1-XTrackCOM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1YfNtmoLYm4d06ul4eu9DZrtIkZrtK7FGfURlJbd0k=;
 b=aGKEve7rfzSnE7MNJr35k0+RdTp3WKxTr1qlsVIi5yZ1Wnv4/u/QE6E09iYKfHpra/iWSq1pGe6f4R7PNxE1odaVmo0mq5E9OobVsZ59P2EulYrYF+6zoRcHvTDR/T+H1ythNSxaLoj2Ex1kHvVLIECAI6p9osPwZ+KHdvWJbXA=
Received: from PR3PR05MB7212.eurprd05.prod.outlook.com (2603:10a6:102:82::23)
 by PR3PR05MB7209.eurprd05.prod.outlook.com (2603:10a6:102:8d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Wed, 24 Feb
 2021 14:27:29 +0000
Received: from PR3PR05MB7212.eurprd05.prod.outlook.com
 ([fe80::c196:a319:995c:7de4]) by PR3PR05MB7212.eurprd05.prod.outlook.com
 ([fe80::c196:a319:995c:7de4%6]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 14:27:29 +0000
From:   Mariusz Madej <Mariusz.Madej@xtrack.com>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "dmurphy@ti.com" <dmurphy@ti.com>
Subject: m_can: a lot of 'Rx FIFO 0 Message Lost' in dmesg
Thread-Topic: m_can: a lot of 'Rx FIFO 0 Message Lost' in dmesg
Thread-Index: AQHXCrhfCk6OVyFHuEmKCny4tDfJ1A==
Date:   Wed, 24 Feb 2021 14:27:28 +0000
Message-ID: <PR3PR05MB7212376CDA795770B7E625E6809F9@PR3PR05MB7212.eurprd05.prod.outlook.com>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=xtrack.com;
x-originating-ip: [185.241.198.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 251dd467-019a-43d3-0b43-08d8d8d050a3
x-ms-traffictypediagnostic: PR3PR05MB7209:
x-microsoft-antispam-prvs: <PR3PR05MB7209773712F2A5A714ABEA11809F9@PR3PR05MB7209.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kHwB/4NKNROflPMnHfTICZMTClHVc9kRwdDgXBeHKS9BmJ4iLnGbzqpcALjwPdyR+V7bn4cSRUd5nKQblyBm2FBUNG+jhSRphygpHG/a7kRFmSuqHjIZGfaLrm7Vm5zSaTbRObuA8lc0DsnvyOFMYgAF2q8jqxJ/DeuJNz/fLnxSY5cPmyonlUn5qYez+k3JcuBssGBb0dRysTqHV+R1BePJi0i/FsRtj47StIEdQqcbhx7nQ2oD5kNuDW4QCaNQaPCkGjJ+xs/BLPZnprb9aarUT/lCq7Uzf8aVcBEVKhqNKbxwopBQYyRPaV91gWw/dOsfO0smz1EkA/+rr3m2blpnhSwy/Mxc/JDnrZdHyHV+IckIaqVDFLdbnEXjs3W8XPwN8Dkqj8T2Sg+n583ebHvsfVdxY2kuiGirWQwo3ywktGMYzEnuYhOVyWd55YYV9azoQ/aB5XrHNdbITMa5FeKbY/5X3YbF2ityMvA/aDIgEImo0JeHmZ6d5A4GHxYYEqumsgzmSkZJJpq0Wc6Esw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR05MB7212.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(376002)(346002)(136003)(396003)(366004)(8676002)(76116006)(66446008)(66556008)(66476007)(86362001)(9686003)(91956017)(64756008)(8936002)(71200400001)(66946007)(2906002)(316002)(6916009)(186003)(55016002)(7696005)(5660300002)(15650500001)(478600001)(83380400001)(6506007)(33656002)(52536014)(4326008)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-2?Q?zzA26U5voeFxJfoIljnp3R5hFFQgtqjfzbJhdd8iDKmFE61AeM1+zKCkSy?=
 =?iso-8859-2?Q?jxQXQVmdI5ok0WdqsPc6dZtSSI3ldvWj3crfIjzIqjTxcCpk3SnusQWdrn?=
 =?iso-8859-2?Q?8qeDIjwmNNQAzeexI25/M72FHy78bBGKG2+IeSiFneWEz5qRwaXl6m3X+7?=
 =?iso-8859-2?Q?82xag/Popp3hbzSLxLDOO/9V1Mib2zTn0cQAio4+fcvizUiyWoYso635nO?=
 =?iso-8859-2?Q?QYz08BD+Vp/8gHlFBekvWdGdwSg9+dTJ5UCZ6x0tXV6WllxjZk25rRVPJD?=
 =?iso-8859-2?Q?+ls6m5r4ZMX0QXf9Z4BN3RTfjq8Q0Z1aE1dfAgFToF1uJeXuImDsvBK7Bc?=
 =?iso-8859-2?Q?0DAL3anmkFlYTa5JlzDwYTO09iSGkfXNIX6J2HmO80RIuw+9BgBd3av+RZ?=
 =?iso-8859-2?Q?ZBLAmgtj7ub4bWDK/OJBl45vDkoYLVHqwCZA8qhZ8lvLyQcxbDvr3qWeXu?=
 =?iso-8859-2?Q?IRlpmPzLDmO/oMFJIh8E8jA02TmNlf/ptDQAz4DsH39fyuxYLxkIiv/muf?=
 =?iso-8859-2?Q?WB6AW6WDOsooZDdJLjPhKtRd+M0ZnY/+k+fbinMM+eza29c48xmuN0Jjse?=
 =?iso-8859-2?Q?ex/lj25axFMpOYWos6wtfJGIcbSg3PeG8i+M9h5uFdKoLP0IYCsWQkpnNK?=
 =?iso-8859-2?Q?2QB3czOCjxsAEI6tdAgm9Mjfy6ITesvH8LrgZG1jRqEZ/SzCATZWI7oUWz?=
 =?iso-8859-2?Q?XFACyin7o3p/uvquIM5Y7OlMyneo/5AZ+R+hypekwk+dA9q5kOt3tMRSQF?=
 =?iso-8859-2?Q?mw4u5cYnxYmkYYzeS71L+YoGI219LkNXoxGEypbWmkvuvWbTLg2M4VrCpH?=
 =?iso-8859-2?Q?k54FKs8DLYwyPDO4KOUzTOPCXOmcR+Uh9TLMvQUQlRZKBMVVKutC32N2qd?=
 =?iso-8859-2?Q?gdIazdEX2/4GRR/sYpUltNbqSCA+G9hcGwkwcr307iNuegtm6dtBBpImwa?=
 =?iso-8859-2?Q?3szp9QoyNxikHed/D0cG+APHr4n+u3RhHOmzd+ueAq5CTeGR8CSIAgmtM0?=
 =?iso-8859-2?Q?YtHffQYqIcbwdhls2OHgRT+vmKnG7mIthb4WZ2NMMjABphm8k/lOl4t2up?=
 =?iso-8859-2?Q?WVExL4lo8ynkgP/Pww2BCyu+wCY8keiieCjqpSo+XrN9bZLmy5Yt60RKRO?=
 =?iso-8859-2?Q?1G7J45j6NBc57J7SPAMjxW6/j7T5dRtsk9f9DR7yh+ZrkLpyd/mRkXVK4m?=
 =?iso-8859-2?Q?C8xSLANRzF/pTB90OfYjNPoOEs9OF4hoSeBo4sJUZOgooNj2fKycpIDCEI?=
 =?iso-8859-2?Q?ACjXur3Glre9UgwHecS7ZBaUXIDDumCP9w/a0XjPky1Ia15IoVLju/jf3v?=
 =?iso-8859-2?Q?yXdXC8jBaFPzB3pYJCv/kbZQveU5bABfTYamIxe/d3VSyG9UUNPxBTfp4l?=
 =?iso-8859-2?Q?SriWaFKc2L?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xtrack.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR05MB7212.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251dd467-019a-43d3-0b43-08d8d8d050a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 14:27:28.9509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0be323cd-18d8-47bb-9b91-3e028441607c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WLXMzk0Xoub8xGwOygT3wEmKrF4stXFwX51Z9RFGbRPDhhT8g8L7pgSKYwYaquKO4E7ygTD7lko5/kxsxz+hRYsKPRwetuuyQdF1Fdu4KWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR05MB7209
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

=0A=
Hi,=0A=
=0A=
I have a problem with m_can controller in my sama5d2 processor.=0A=
Under heavy can traffic it happens that my device starts to report (dmesg):=
=0A=
=0A=
[   77.610000] m_can_platform f8054000.can can0: Rx FIFO 0 Message Lost=0A=
[   77.620000] m_can_platform f8054000.can can0: Rx FIFO 0 Message Lost=0A=
[   77.630000] m_can_platform f8054000.can can0: Rx FIFO 0 Message Lost=0A=
[   77.630000] m_can_platform f8054000.can can0: Rx FIFO 0 Message Lost=0A=
[   77.640000] m_can_platform f8054000.can can0: Rx FIFO 0 Message Lost=0A=
[   77.640000] m_can_platform f8054000.can can0: Rx FIFO 0 Message Lost=0A=
[   77.650000] m_can_platform f8054000.can can0: Rx FIFO 0 Message Lost=0A=
[   77.660000] m_can_platform f8054000.can can0: Rx FIFO 0 Message Lost=0A=
[   77.660000] m_can_platform f8054000.can can0: Rx FIFO 0 Message Lost=0A=
=0A=
what causes large load problem in my system.=0A=
=0A=
I think I have a clue what is going on but my kernel knowledge is low so i =
want=0A=
You to tell me if I am right or not. So:=0A=
=0A=
The only place in m_can.c file, where interrupt register is cleared is func=
tion=0A=
called when interrupt arrives=0A=
=0A=
static irqreturn_t m_can_isr(int irq, void *dev_id)=0A=
{=0A=
.=0A=
.=0A=
        /* ACK all irqs */=0A=
        if (ir & IR_ALL_INT)=0A=
                m_can_write(cdev, M_CAN_IR, ir);=0A=
.=0A=
.=0A=
}=0A=
=0A=
But when we enter 'NAPI mode' in heavy load we are never get to this functi=
on=0A=
until load gets lower and interrupts are enabled again. In this situation,=
=0A=
this code:=0A=
=0A=
static int m_can_do_rx_poll(struct net_device *dev, int quota)=0A=
{=0A=
        struct m_can_classdev *cdev =3D netdev_priv(dev);=0A=
        u32 pkts =3D 0;=0A=
        u32 rxfs;=0A=
=0A=
        rxfs =3D m_can_read(cdev, M_CAN_RXF0S);=0A=
        if (!(rxfs & RXFS_FFL_MASK)) {=0A=
                netdev_dbg(dev, "no messages in fifo0\n");=0A=
                return 0;=0A=
        }=0A=
=0A=
        while ((rxfs & RXFS_FFL_MASK) && (quota > 0)) {=0A=
                if (rxfs & RXFS_RFL)=0A=
                        netdev_warn(dev, "Rx FIFO 0 Message Lost\n");=0A=
=0A=
                m_can_read_fifo(dev, rxfs);=0A=
=0A=
                quota--;=0A=
                pkts++;=0A=
                rxfs =3D m_can_read(cdev, M_CAN_RXF0S);=0A=
        }=0A=
=0A=
        if (pkts)=0A=
                can_led_event(dev, CAN_LED_EVENT_RX);=0A=
=0A=
        return pkts;=0A=
}=0A=
=0A=
will always have (rxfs & RXFS_RFL) =3D=3D true until interrupt are enabled =
again.=0A=
That is why we got so many messages in a row for so long time. So clearing=
=0A=
RXFS_RFL bit after warning is issued could be a solution.=0A=
=0A=
Can You tell me if I am right?=0A=
=0A=
Regards=0A=
Mariusz=
